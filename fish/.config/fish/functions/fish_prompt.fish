function fish_prompt --description 'Write out the prompt'
    set host (hostname)

    switch $host
        case 's12-hpc*'
            # show full hostname for cluster nodes
            set host_alias $host
            set prefix (set_color bryellow)'⚡'(set_color normal)
        case 'develop.marvin.vito.local'
            set host_alias DEV
            set prefix (set_color bryellow)'⚡'(set_color normal)
        case 'login.marvin.vito.local'
            set host_alias LOGIN
            set prefix (set_color bryellow)'⚡'(set_color normal)
        case '*'
            set host_alias $host
            set prefix (set_color brgreen)'🏡'(set_color normal)
    end

    echo -n "$prefix "
    set -l last_status $status
    set -l normal (set_color normal)

    set -l status_color (set_color brgreen)
    set -l cwd_color (set_color $fish_color_cwd)
    set -l vcs_color (set_color brpurple)
    set -l prompt_status ""

    set -q fish_prompt_pwd_dir_length
    or set -lx fish_prompt_pwd_dir_length 0

    set -l suffix '❯'
    if functions -q fish_is_root_user; and fish_is_root_user
        if set -q fish_color_cwd_root
            set cwd_color (set_color $fish_color_cwd_root)
        end
        set suffix '#'
    end

    if test $last_status -ne 0
        set status_color (set_color $fish_color_error)
        set prompt_status $status_color"["$last_status"]"$normal
    end

    echo -s (prompt_login) ' ' $cwd_color (prompt_pwd) $vcs_color (fish_vcs_prompt) $normal ' ' $prompt_status
    echo -n -s $status_color $suffix ' ' $normal
end
