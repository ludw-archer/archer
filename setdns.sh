#!/usr/bin/env bash

# Cloudflare Family Filter DNS

DNS4="1.1.1.3 1.0.0.3"
DNS6="2606:4700:4700::1113"

# Display available connections (UUID, Name, Device)

echo "Select the UUID of the connection to apply DNS settings:"
nmcli -t --fields UUID,DEVICE,TYPE,NAME connection show
echo
read -p "Enter the UUID: " UUID

# Check if input is empty

if [[ -z "$UUID" ]]; then
    echo "No UUID provided. Aborting."
    exit 1
fi

echo "Applying DNS settings to $UUID ..."

# Set IPv4 and IPv6 DNS and prevent DHCP/VPN overrides

nmcli connection modify "$UUID" ipv4.dns "$DNS4"
nmcli connection modify "$UUID" ipv4.ignore-auto-dns yes
nmcli connection modify "$UUID" ipv6.dns "$DNS6"
nmcli connection modify "$UUID" ipv6.ignore-auto-dns yes

# Optional: Enable DNS-over-TLS (encrypted DNS queries)

nmcli connection modify "$UUID" connection.dns-over-tls yes

# Reactivate connection silently

nmcli connection up "$UUID" >/dev/null 2>&1

echo "DNS successfully applied!"
echo
echo "Check with:"
echo "  cat /etc/resolv.conf"
echo

# Make this setup previously to script

# sudo nano /etc/NetworkManager/conf.d/dns.conf
# [main]
# dns=default
# sudo mv /etc/resolv.conf /etc/resolv.conf.backup
# sudo ln -s /run/NetworkManager/resolv.conf /etc/resolv.conf
# sudo systemctl restart NetworkManager

# systemctl status systemd-resolved
# systemctl is-active NetworkManager
# systemctl is-active systemd-networkd
# nmcli connection show

# nmcli connection modify "UUID" ipv4.ignore-auto-dns yes
# nmcli connection modify "UUID" ipv4.dns "1.1.1.3 1.0.0.3"
# nmcli connection modify "UUID" ipv6.ignore-auto-dns yes
# nmcli connection modify "UUID" ipv6.dns "2606:4700:4700::1113"
# nmcli connection up "UUID"

# nmcli device show wlan0 [ or: tun0 wg0 wlp2s0 ]
# cat /etc/resolv.conf
# curl https://1.1.1.3/cdn-cgi/trace | grep server=
# curl https://1.0.0.3/cdn-cgi/trace | grep server=
#
