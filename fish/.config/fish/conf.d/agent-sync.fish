if status is-interactive; and command -q agent-sync-hook
    agent-sync-hook >/dev/null 2>&1 &
    disown
end
