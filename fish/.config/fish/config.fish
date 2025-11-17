if status is-interactive
    # Commands to run in interactive sessions can go here
end

#########################################################
# alias & abbr
alias gb='git branch'
alias gl='git pull'
alias gp='git push'

abbr --add gcm git commit -m
abbr --add gst git status
abbr --add gss git status -s


# don't show any greetings
set -g fish_greeting ""
set -g fish_greeting "One line at a time."


zoxide init fish | source
