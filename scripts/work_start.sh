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

usage() {
    echo "Usage: $(basename "$0") [-u]"
    echo "  -u  update devstack"
    exit 1
}

update_devstack=false

while getopts ":u" opt; do
    case $opt in
        u) update_devstack=true ;;
        *) usage ;;
    esac
done

main() {
    echo "I need sudo... for VPN"
    request_sudo_access
    open_app "Ghostty"
    open_app "Orbstack"
    open_app "Slack"
    sleep 1
    /usr/local/bin/aerospace workspace "Terminal"
    echo "All apps opened ✅"
    sudo sh $HOME/.config/scripts/start_vpn.sh $WS_VPN_PATH
    if $update_devstack; then
        sleep 1
        echo "Updating devstack... 🐳"
        sh $HOME/websupport/workspace/tools/development-stack/bin/update.sh
        echo "Done updating devstack 🔥"
    fi
    open_app "Ghostty"
}

error_handler() {
    echo "An error occurred. Exiting script. 😱"
    exit 1
}

trap error_handler ERR

main
