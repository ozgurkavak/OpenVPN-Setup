#!/bin/bash

# Ask user for confirmation
if (whiptail --title "Remove OpenVPN" --yesno "Are you sure you want to remove\
OpenVPN and revert your system to its previous state?" 8 78)
 echo "OpenVPN will be removed."
else
 echo "Cancelled"
 exit
fi

# Remove openvpn
apt-get -y remove openvpn

# Remove openvpn-related directories
rm -r /etc/openvpn /home/pi/ovpns

# Remove firewall script and reference to it in interfaces
sed -i '/firewall-openvpn-rules.sh/d' /etc/network/interfaces
rm /etc/firewall-openvpn-rules.sh

# Disable IPv4 forwarding
sed -i '/net.ipv4.ip_forward=1/c\
#net.ipv4.ip_forward=1' /etc/sysctl.conf
sysctl -p

whiptail --title "Removal Complete" --msgbox "OpenVPN has been removed and your\
previous settings have been restored." 8 78
