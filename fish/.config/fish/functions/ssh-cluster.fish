function ssh-cluster --wraps ssh --description 'SSH with VITO_PASSWORD from Keychain injected on remote'
    if test (count $argv) -eq 0
        echo "usage: ssh-cluster [ssh options …] host" >&2
        return 1
    end

    if not type -q security
        echo "ssh-cluster: requires macOS security(1)" >&2
        return 1
    end

    set -l pw (security find-generic-password -a "$USER" -s "VITO_PASSWORD" -w 2>/dev/null)
    if test -z "$pw"
        echo "ssh-cluster: VITO_PASSWORD not in Keychain" >&2
        return 1
    end

    set -l quoted (bash -c 'printf %q "$1"' _ "$pw")
    set -e pw

    command ssh -t $argv "export VITO_PASSWORD=$quoted; exec -l \"\$SHELL\""
end
