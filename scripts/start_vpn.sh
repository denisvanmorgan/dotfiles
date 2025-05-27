#!/bin/bash

source $HOME/.variables

start_vpn() {
    local config_path=$1
    
    if [[ ! -f "$config_path" ]]; then
        echo "VPN config file not found: $config_path"
        return 1
    fi
    
    nohup "$OPENVPN_BIN" --config "$config_path" > /dev/null 2>&1 &
    
    sleep 3
    if pgrep -x "openvpn" > /dev/null; then
        echo "VPN started successfully 💻"
        return 0
    else
        echo "VPN failed to start 😡"
        return 1
    fi
}

start_vpn $1
