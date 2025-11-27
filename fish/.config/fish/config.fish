if status is-interactive
    # Commands to run in interactive sessions can go here
end

#########################################################
# alias & abbr
# alias gb='git branch'
# alias gl='git pull'
# alias gp='git push'

# abbr --add gcm git commit -m
# abbr --add gst git status
# abbr --add gss git status -s
abbr --add lla ls -la

# don't show any greetings
set -g fish_greeting ""
set -g fish_greeting "One line at a time."

zoxide init fish | source

if test -d /opt/homebrew
    /opt/homebrew/bin/brew shellenv | source
end

if test -f /usr/share/lmod/lmod/init/profile.fish
    source /usr/share/lmod/lmod/init/profile.fish
end

if type -q pixi
    pixi completion --shell fish | source
end

module load pixi


# load shared environment variables
source ~/.env ^/dev/null 2>/dev/null; or begin
    # fish-syntax fallback
    set -x VITO_PASSWORD "value"
end
