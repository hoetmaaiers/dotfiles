# Prefer the stable agent symlink (updated by ~/.ssh/rc on ForwardAgent SSH).
# Only override when present so local Mac IdentityAgent stays untouched.
if test -L $HOME/.ssh/ssh_auth_sock
    set -gx SSH_AUTH_SOCK $HOME/.ssh/ssh_auth_sock
end
