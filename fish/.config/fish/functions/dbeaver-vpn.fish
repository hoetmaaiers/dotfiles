function dbeaver-vpn --description "Launch DBeaver through vpn-jumphost"
    set -l root /Users/robin/Playground/vpn-jumphost
    command just --justfile "$root/justfile" --working-directory "$root" proxychains-setup; and command just --justfile "$root/justfile" --working-directory "$root" dbeaver
end
