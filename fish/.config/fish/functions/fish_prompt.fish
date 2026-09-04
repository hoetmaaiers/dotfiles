function fish_prompt
    set -l last_status $status
    set -l normal (set_color normal)

    # Stronger versions of the Maple Mono preview colors for light backgrounds.
    set -l user_color (set_color --italics 9A6700)
    set -l label_color (set_color 57606A)
    set -l path_color (set_color 1A7F37)
    set -l branch_color (set_color 0969DA)
    set -l prompt_color (set_color 8250DF)
    set -l error_color (set_color CF222E)

    # Keep development environments visible without changing the prompt shape.
    if set -q DEVENV_PROJECT_NAME
        echo -n -s (set_color 0550AE)'❄ ' $label_color'['(set_color 1A7F37)$DEVENV_PROJECT_NAME$label_color'] '
    else if set -q DEVENV_STATE
        echo -n -s (set_color 0550AE)'❄ ' $label_color'[devenv] '
    end

    set -l identity $USER
    if set -q SSH_TTY
        set identity "$USER@$hostname"
    end

    if functions -q fish_is_root_user; and fish_is_root_user
        set user_color $error_color
    end

    set -q fish_prompt_pwd_dir_length; or set -lx fish_prompt_pwd_dir_length 0
    echo -n -s $user_color$identity' ' $label_color'in ' $path_color(prompt_pwd)

    set -l branch (command git symbolic-ref --quiet --short HEAD 2>/dev/null)
    if test -z "$branch"
        set branch (command git rev-parse --short HEAD 2>/dev/null)
    end
    if test -n "$branch"
        echo -n -s ' ' $label_color'on ' $branch_color' '$branch
    end

    set -l suffix '❯ '

    if test $last_status -ne 0
        echo -n -s ' ' $error_color"[$last_status]"
        set prompt_color $error_color
    end

    if functions -q fish_is_root_user; and fish_is_root_user
        set suffix '# '
    end

    echo
    echo -n -s $prompt_color$suffix$normal
end
