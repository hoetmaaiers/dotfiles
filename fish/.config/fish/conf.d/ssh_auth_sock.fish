# Keep a live SSH_AUTH_SOCK (e.g. set by sshd or already valid before re-sourcing).
# Otherwise fall back to the stable symlink (updated by ~/.ssh/rc on ForwardAgent SSH),
# but only when it points to an existing socket. Local Mac IdentityAgent stays untouched.
if not test -S "$SSH_AUTH_SOCK"; and test -S $HOME/.ssh/ssh_auth_sock
    set -gx SSH_AUTH_SOCK $HOME/.ssh/ssh_auth_sock
end
