#!/bin/bash

source $HOME/.variables

request_sudo_access() {
    if ! sudo -v; then
        echo "Failed to obtain sudo access. Exiting. 🚫"
        exit 1
    fi

    (while true; do 
        sudo -E -n true
        sleep 60
        kill -0 "$$" || exit
    done 2>/dev/null &)
}

open_app() {
    local app_name=$1
    open -a $app_name
}

open_firefox_instance() {
    local profile=$1
    open -a "Firefox" -n --args -P $profile
}

main() {
    echo "I need sudo... for VPN"
    request_sudo_access
    open_firefox_instance "WS"
    sleep 1.5
    /usr/local/bin/aerospace move-node-to-workspace --window-id $(/usr/local/bin/aerospace list-windows --all | grep Firefox | awk -F '|' '{print $1}') "BrowserWork"
    open_firefox_instance "Personal"
    open_app "Ghostty"
    open_app "Orbstack"
    open_app "Slack"
    open_app "Spark"
    sleep 1
    /usr/local/bin/aerospace workspace "Terminal"
    echo "All apps opened ✅"
    sudo sh $HOME/.config/scripts/start_vpn.sh $WS_VPN_PATH
    sleep 1
    echo "Updating devstack... 🐳"
    sh $HOME/workspace/tools/development-stack/bin/update.sh
    echo "Done updating devstack 🔥"
}

error_handler() {
    echo "An error occurred. Exiting script. 😱"
    exit 1
}

trap error_handler ERR

main
