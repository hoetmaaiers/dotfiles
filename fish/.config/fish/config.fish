if status is-interactive
    #########################################################
    # alias & abbr
    abbr --add ls 'eza'
    abbr --add lla 'eza -lah'
    abbr --add ll 'eza -lah'
    abbr --add lt 'eza --tree'
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

    # Lmod / modules (Linux/HPC)
    if test -f /usr/share/lmod/lmod/init/profile.fish
        source /usr/share/lmod/lmod/init/profile.fish

        set -l user_modulepath $HOME/dotfiles/lmod/modules
        if type -q module; and test -d $user_modulepath
            module use $user_modulepath
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

    function ngrok
        env TERM=xterm-256color command ngrok $argv
    end

    set -gx VITO_USERNAME houdmeyr # static VITO username
    set -gx VITO_EMAIL robin.houdmeyers@vito.be # static VITO email address

    # load VITO_PASSWORD from macOS Keychain
    if type -q security
        set -l vito_password (security find-generic-password -a "$USER" -s "VITO_PASSWORD" -w 2>/dev/null)
        if test -n "$vito_password"
            set -gx VITO_PASSWORD "$vito_password"
        end
    end

end

direnv hook fish | source

if test (uname -s) = Darwin
    if test -d $HOME/.lmstudio/bin
        fish_add_path $HOME/.lmstudio/bin
    end
end

