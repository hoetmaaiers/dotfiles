// Markdown pane: Preview / Source, props: { file, machine?, mode? }.
// Source is always editable and autosaves shortly after you stop typing.
// Files on another machine open read-only (writeTextFile is local only).

import { View, div } from "gpui-kit";
import { v_flex, h_flex, TextView, Editor, EditorState } from "gpui-base";
import { props, readTextFile, writeTextFile, theme, settings, shared, setShared } from "herdr";

const MODES = [["preview", "Preview"], ["source", "Source"]];
const AUTOSAVE_MS = 800;
const READ_WIDTH = 760;

// Splits markdown into prose and fenced code so each code block can have its own Copy button.
function segments(text) {
  const out = [];
  let prose = [], code = null, fence = null, lang = "";
  for (const line of text.split("\n")) {
    if (code === null) {
      const m = /^\s{0,3}(`{3,}|~{3,})\s*([^\s`]*)/.exec(line);
      if (m) {
        if (prose.length) out.push({ prose: prose.join("\n") });
        prose = []; code = []; fence = m[1]; lang = m[2];
      } else prose.push(line);
    } else if (new RegExp(`^\\s{0,3}${fence[0]}{${fence.length},}\\s*$`).test(line)) {
      out.push({ code: code.join("\n"), lang });
      code = null;
    } else code.push(line);
  }
  if (code !== null) out.push({ code: code.join("\n"), lang });
  else if (prose.length) out.push({ prose: prose.join("\n") });
  return out;
}

export default class Markdown extends View {
  init(p, cx) {
    this.text = null;      // what is on disk, as last read or written
    this.error = null;
    this.state = null;     // the editor
    this.changedAt = 0;
    this.saving = false;
    this.conflict = null;  // disk text when the file changed under unsaved edits
    this.mode = MODES.some(([m]) => m === p?.mode) ? p.mode : "preview";
    this.load(cx);
    cx.timer.every(1500, (cx) => { this.load(cx); this.maybeSave(cx); });
  }

  wide() { return shared("markdown.width") === "full"; }

  local() { return !props()?.machine; }

  current() { return this.state ? this.state.value() : this.text; }

  dirty() { return this.state !== null && this.state.value() !== this.text; }

  makeEditor(cx) {
    const t = theme();
    this.state = EditorState.new({
      language: "markdown", readonly: !this.local(), value: this.text, soft_wrap: true,
      font_family: settings().font_family, font_size: 13,
      syntax: { keyword: t.ansi5, string: t.ansi2, comment: t.dim, function: t.ansi4, type: t.ansi3, number: t.ansi1, constant: t.ansi6 },
    });
    this.state.on("change", (_e, cx) => {
      if (this.dirty()) this.changedAt = Date.now();
      cx.notify();
    });
  }

  load(cx) {
    const { file, machine } = props() ?? {};
    if (!file) { this.error = "No file given"; cx.notify(); return; }
    cx.spawn(async (cx) => {
      let disk = null;
      try { disk = await readTextFile(file, { on: machine ?? null }); }
      catch (e) { this.error = String(e); cx.notify(); return; }
      if (disk === null) { this.error = "File not found: " + file; cx.notify(); return; }
      if (this.text === null) { this.text = disk; this.error = null; this.makeEditor(cx); cx.notify(); return; }
      if (disk === this.text && !this.error) return;
      this.error = null;
      if (this.dirty()) { if (disk !== this.text) this.conflict = disk; cx.notify(); return; }
      this.text = disk;
      this.state.set_value(disk);
      cx.notify();
    });
  }

  maybeSave(cx) {
    if (this.dirty() && !this.conflict && Date.now() - this.changedAt >= AUTOSAVE_MS) this.save(cx);
  }

  save(cx) {
    if (this.saving || !this.local() || !this.dirty()) return;
    const { file } = props();
    const value = this.state.value();
    this.saving = true;
    cx.spawn(async (cx) => {
      try {
        await writeTextFile(file, value, this.text);
        this.text = value;
      } catch (e) {
        // Stale snapshot: the file changed on disk since we read it.
        const disk = await readTextFile(file).catch(() => null);
        if (disk !== null && disk !== this.text) this.conflict = disk;
        else this.error = "Save failed: " + String(e);
      }
      this.saving = false;
      cx.notify();
    });
  }

  setMode(mode, cx) {
    this.mode = mode;
    if (mode === "preview") this.save(cx);
    cx.notify();
  }

  async close(cx) {
    if (this.dirty() && !this.conflict && this.local()) {
      try { await writeTextFile(props().file, this.state.value(), this.text); } catch {}
    }
  }

  button(id, label, t, onClick) {
    return div().id(id).px(8).py(3).rounded(5).text_size(12).text_color(t.foreground).bg(t.raised)
      .cursor_pointer().hover((s) => s.bg(t.hover)).on_click((_e, cx) => onClick(cx)).child(label);
  }

  tab(id, label, t) {
    const on = this.mode === id;
    return div().id(`md-tab-${id}`).px(10).py(4).rounded(6).text_size(12)
      .text_color(on ? t.foreground : t.muted)
      .when(on, (el) => el.bg(t.raised))
      .cursor_pointer().hover((s) => s.bg(t.hover)).on_click((_e, cx) => this.setMode(id, cx))
      .child(label);
  }

  segment(s, i, t) {
    if (s.prose !== undefined) return TextView.markdown(`md-${i}`, s.prose).selectable(true);
    const copied = this.copied === i, show = copied || this.hovered === i;
    return v_flex().id(`md-code-${i}`).my(6).rounded(6).bg(t.background).border_1().border_color(t.border).overflow_hidden()
      .on_hover((over, cx) => {
        if (over) this.hovered = i;
        else if (this.hovered === i) this.hovered = null;
        cx.notify();
      })
      .child(h_flex().h(26).px(8).items_center().text_size(11).text_color(t.dim)
        .child(div().flex_1().child(s.lang || "text"))
        .when(show, (el) => el.child(div().id(`md-copy-${i}`).px(8).py(2).rounded(5).cursor_pointer().text_color(copied ? t.done : t.muted)
          .hover((h) => h.bg(t.hover))
          .on_click((_e, cx) => {
            cx.write_to_clipboard(s.code);
            this.copied = i;
            cx.notify();
            cx.timer.after(1500, (cx) => { if (this.copied === i) { this.copied = null; cx.notify(); } });
          })
          .child(copied ? "Copied" : "Copy"))))
      .child(div().id(`md-codetext-${i}`).px(8).pb(8).overflow_x_scrollbar()
        .font_family(settings().font_family).text_size(13).whitespace_nowrap().child(s.code));
  }

  status() {
    if (!this.local()) return "Read-only (remote)";
    if (this.conflict) return "Changed on disk";
    if (this.saving) return "Saving…";
    return this.dirty() ? "Unsaved" : "Saved";
  }

  render() {
    const t = theme();
    const file = (props()?.file ?? "").split("/").pop();
    let body;
    if (this.error && this.text === null) body = div().p(16).text_color(t.muted).child(this.error);
    else if (this.text === null) body = div().p(16).text_color(t.dim).child("Loading…");
    else {
      const inner = this.mode === "source"
        ? Editor.new(this.state).size_full().min_h(0)
        : v_flex().id("md-scroll").size_full().min_h(0).px(12).py(8).text_size(14).overflow_y_scrollbar()
            .children(segments(this.current()).map((s, i) => this.segment(s, i, t)));
      // Readable width keeps lines short and centered; full uses the whole pane.
      body = h_flex().flex_1().min_h(0).justify_center()
        .child(v_flex().h_full().min_h(0).w_full().when(!this.wide(), (el) => el.max_w(READ_WIDTH)).child(inner));
    }

    return v_flex().id("md-root").size_full().min_h(0).bg(t.surface).text_color(t.foreground)
      .child(h_flex().h(36).flex_none().px(8).gap(4).items_center().border_b(1).border_color(t.border)
        .children(MODES.map(([id, label]) => this.tab(id, label, t)))
        .child(div().flex_1().min_w(0).truncate().text_right().px(8).text_size(12).text_color(t.dim).child(`${file} · ${this.status()}`))
        .child(div().id("md-width").px(8).py(4).rounded(6).text_size(12).text_color(t.muted)
          .cursor_pointer().hover((s) => s.bg(t.hover))
          .on_click(() => setShared("markdown.width", this.wide() ? "readable" : "full"))
          .child(this.wide() ? "Full width" : "Readable")))
      .when(Boolean(this.conflict), (el) => el.child(
        h_flex().px(12).py(6).gap(8).items_center().text_size(12).bg(t.raised)
          .child(div().flex_1().text_color(t.blocked).child("This file changed on disk while you were editing."))
          .child(this.button("md-reload", "Load disk version", t, (cx) => {
            this.text = this.conflict; this.state.set_value(this.conflict); this.conflict = null; cx.notify();
          }))
          .child(this.button("md-keep", "Keep mine", t, (cx) => {
            this.text = this.conflict; this.conflict = null; this.changedAt = 0; this.save(cx); cx.notify();
          }))))
      .when(Boolean(this.error) && this.text !== null, (el) => el.child(div().px(12).py(6).text_size(12).text_color(t.blocked).child(this.error)))
      .child(body);
  }
}
