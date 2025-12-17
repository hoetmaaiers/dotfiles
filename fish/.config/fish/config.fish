if status is-interactive
    #########################################################
    # alias & abbr
    abbr --add lla 'ls -la'
    abbr -a gca 'git commit --amend'
    abbr -a gcaf 'git commit --amend --no-edit'

    # greeting (single line)
    set -g fish_greeting "One line at a time."

    # zoxide (if installed)
    if type -q zoxide
        zoxide init fish | source
    end

    # Homebrew (Apple Silicon default prefix)
    if test -d /opt/homebrew
        /opt/homebrew/bin/brew shellenv | source
    end

    # Lmod / modules
    if test -f /usr/share/lmod/lmod/init/profile.fish
        source /usr/share/lmod/lmod/init/profile.fish

        # # only run module if it exists
        # if type -q module
        #     module load pixi
        # end
    end

    # pixi completions (if pixi is installed)
    if type -q pixi
        pixi completion --shell fish | source
    end

    # load shared environment variables (if file exists)
    if test -f ~/.env
        # silence stdout/stderr from sourcing
        source ~/.env >/dev/null 2>/dev/null
    else
        # fish-syntax fallback
        set -x VITO_PASSWORD value
    end

end

direnv hook fish | source
