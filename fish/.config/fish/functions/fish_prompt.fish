function fish_prompt
    set -l last_status $status
    set -l normal (set_color normal)
    set -l bold_blue (set_color -o brblue)
    set -l brwhite (set_color brwhite)

    # Initialize color variables with defaults if not set
    # Extract only the color name (first word) to handle cases where --theme flags are included
    set -l cwd_color brblue
    if set -q fish_color_cwd; and test -n "$fish_color_cwd"
        set -l color_val (string trim (echo $fish_color_cwd | string split ' ')[1])
        if test -n "$color_val"
            set cwd_color $color_val
        end
    end

    set -l error_color red
    if set -q fish_color_error; and test -n "$fish_color_error"
        set -l color_val (string trim (echo $fish_color_error | string split ' ')[1])
        if test -n "$color_val"
            set error_color $color_val
        end
    end

    # Ensure colors are never empty
    test -n "$cwd_color"; or set cwd_color brblue
    test -n "$error_color"; or set error_color red

    # --- 1. Top Line: Environment & Path ---

    # Devenv Logic
    if set -q DEVENV_PROJECT_NAME
        echo -n (set_color cyan)"❄️ "(set_color -o green)"[$DEVENV_PROJECT_NAME] "
    else if set -q DEVENV_STATE
        echo -n (set_color cyan)"❄️ (devenv) "
    end

    # Hostname / Environment Logic
    # Using the built-in $hostname variable is faster than calling the command
    switch $hostname
        case 's12-hpc*' 's12-develop' 's12-login'
            echo -n (set_color bryellow)'⚡ '
        case '*'
            echo -n (set_color brgreen)'🏡 '
    end

    # User & Host (only show if SSH or Root)
    if set -q SSH_TTY; or functions -q fish_is_root_user; and fish_is_root_user
        echo -n (set_color brmagenta)(whoami)"@$hostname "
    end

    # Current Directory
    set -q fish_prompt_pwd_dir_length; or set -lx fish_prompt_pwd_dir_length 0
    echo -n (set_color $cwd_color)(prompt_pwd)

    # VCS Prompt
    echo -n (set_color brpurple)(fish_vcs_prompt)

    # --- 2. Error Handling & New Line ---

    set -l suffix '❯'
    set -l status_color (set_color brgreen)

    if test $last_status -ne 0
        set status_color (set_color $error_color)
        echo -n " " (set_color -b $error_color $brwhite)" $last_status "(set_color normal)
        set suffix '✖'
    end

    # Root user suffix change
    if functions -q fish_is_root_user; and fish_is_root_user
        set suffix '#'
    end

    # Final prompt line
    echo ""
    test -n "$status_color"; or set status_color (set_color brgreen)
    echo -n -s $status_color $suffix ' ' $normal
end
