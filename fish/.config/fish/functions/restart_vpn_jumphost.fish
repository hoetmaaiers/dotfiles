function restart_vpn_jumphost
    launchctl kickstart -k gui/(id -u)/sas.vpn-jumphost
end
