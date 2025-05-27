#!/bin/bash

disconnect_vpn() {
    pkill -2 openvpn
    sleep 1
    
    if pgrep -x openvpn > /dev/null; then
        pkill -9 openvpn
        echo "VPN forcefully terminated"
    else
        echo "VPN disconnected gracefully"
    fi
}

vpn_status() {
    if pgrep -x openvpn > /dev/null; then
        echo "VPN is currently running"
        ps aux | grep openvpn
    else
        echo "No VPN connection active"
    fi
}

vpn_status
disconnect_vpn
vpn_status
