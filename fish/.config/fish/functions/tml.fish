# Create a tmux layout for dev with editor, ai, and terminal
function tml
    # first arg is the ai command (eg: c, cx)
    set -l ai $argv[1]
    set -l current_dir $PWD

    # If we're not already inside tmux, start a session and re-run inside it
    if test -z "$TMUX"
        tmux new-session "bash -ic 'tml $ai; exec bash'"
        return
    end

    # Get current pane ID (will become editor pane after splits)
    set -l editor_pane (tmux display-message -p '#{pane_id}')

    # Split window vertically: bottom 15%, top 85%
    tmux split-window -v -p 15 -c "$current_dir"

    # Go back to top pane and split it horizontally: right 30%, left 70%
    tmux select-pane -t "$editor_pane"
    tmux split-window -h -p 30 -c "$current_dir"

    # After horizontal split, cursor is in the new right pane
    set -l ai_pane (tmux display-message -p '#{pane_id}')
    if test -n "$ai"
        tmux send-keys -t "$ai_pane" "$ai" C-m
    end

    # Run nvim in the left pane
    if test -n "$EDITOR"
        tmux send-keys -t "$editor_pane" "$EDITOR ." C-m
    else
        tmux send-keys -t "$editor_pane" "nvim ." C-m
    end

    # Focus editor pane
    tmux select-pane -t "$editor_pane"
end

# Create a dev layout using tmux with editor, opencode, and terminal
function nic
    tml c
end

# Create a dev layout using tmux with editor, claude, and terminal
function nicx
    tml cx
end
