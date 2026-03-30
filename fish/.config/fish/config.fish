if status is-interactive
    #########################################################
    # alias & abbr
    abbr --add lla 'ls -la'
    abbr -a gca 'git commit --amend'
    abbr -a gcaf 'git commit --amend --no-edit'

    fish_vi_key_bindings

    fish_add_path $HOME/.local/bin
    fish_add_path $HOME/.pixi/bin
    fish_add_path $HOME/.cargo/bin

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

        if type -q module
            set -l user_modulepath /home/houdmeyr/dotfiles/lmod/modules
            if test -d $user_modulepath
                module use $user_modulepath
            end
        end
    end

    # pixi completions (if pixi is installed)
    if type -q pixi
        pixi completion --shell fish | source
    end

    # yazi
    function y
        set tmp (mktemp -t "yazi-cwd.XXXXXX")
        command yazi $argv --cwd-file="$tmp"
        if read -z cwd <"$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
            builtin cd -- "$cwd"
        end
        rm -f -- "$tmp"
    end

    # load VITO_* from .bash_profile (run bash and capture exports)
    if test -f ~/.bash_profile
        set -gx VITO_USERNAME (bash -lc 'source ~/.bash_profile 2>/dev/null; echo "$VITO_USERNAME"')
        set -gx VITO_PASSWORD (bash -lc 'source ~/.bash_profile 2>/dev/null; echo "$VITO_PASSWORD"')
    end

end

direnv hook fish | source
