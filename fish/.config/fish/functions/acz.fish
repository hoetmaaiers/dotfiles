function acz --wraps chezmoi --description 'chezmoi for the agent-config repo (separate from dotfiles)'
    chezmoi --config ~/.config/agent-config/chezmoi.toml --source ~/agent-config $argv
end
