#!/bin/bash

# Enter Var's
echo "Enter Wifi Name (SSID):"
read SSID
echo "Enter the Wifi channel (1-11):"
read CHANNEL

#basic pid check and kill
airmon-ng check kill

#start moniter mode on wlan0
airmon-ng start wlan0

# config wlan0
ip link set wlan0 down
ifconfig wlan0 192.168.0.1 netmask 255.255.255.0
route add -net 192.168.0.0 netmask 255.255.255.0 gw 192.168.0.1
ip link set wlan0 up

#kill interfering pid's
ss -lp "sport = :domain" 
if [ $? -eq 0 ]; then
    PID=$(ss -lp "sport = :domain" | grep -oP '\d+(?=\s.*\s)')
    echo "Killing process with PID: $PID"
    kill -9 $PID
fi

# iptable stuff
iptables --table nat --append POSTROUTING --out-interface eth0 -j MASQUERADE
iptables --append FORWARD --in-interface wlan0 -j ACCEPT
echo 1 > /proc/sys/net/ipv4/ip_forward
sysctl net.ipv4.ip_forward

#create dnsmasq.conf
cat > dnsmasq.conf << EOF
interface=wlan0
dhcp-range=192.168.0.2, 192.168.0.30, 255.255.255.0, 12h
dhcp-option=3, 192.168.0.1
dhcp-option=6, 192.168.0.1
server=8.8.8.8
log-queries
log-dhcp
listen-address=127.0.0.1
EOF

#run dnsmasq in 2nd window (otherwise the script below is not ran)
gnome-terminal -- bash -c "dnsmasq -C dnsmasq.conf -d; exec bash"

# Step 8: Create hostapd.conf file
cat > hostapd.conf << EOF
interface=wlan0
driver=nl80211
ssid=$SSID
hw_mode=g
channel=$CHANNEL
macaddr_acl=0
ignore_broadcast_ssid=0
EOF

#use the created conf file with hostapd
hostapd hostapd.conf
