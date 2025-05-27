#!/bin/bash

request_sudo_access() {
    if ! sudo -v; then
        echo "Failed to obtain sudo access. Exiting. 🚫"
        exit 1
    fi

    (while true; do 
        sudo -n true
        sleep 60
        kill -0 "$$" || exit
    done 2>/dev/null &)
}

close_app() {
    local app_name="$1"
    echo "Closing $app_name..."
    pkill -x "$app_name"
}

main() {
    echo "I need sudo... for VPN disconnection"
    request_sudo_access
    pkill -f "firefox.*-P WS"
    close_app "Ghostty"
    close_app "Slack"
    close_app "Spark"
    close_app "Spotify"
    echo "Closing PhpStorm..."
    pgrep -fl phpstorm | awk '{print $1}' | xargs kill -9
    echo "Closing OrbStack..."
    osascript -e 'quit app "Orbstack"'
    echo "Disconnecting VPN... 🔌"
    sudo sh $HOME/.config/kill_vpn.sh
    /usr/local/bin/aerospace workspace "Terminal" > /dev/null 2>&1 &
    echo "All apps closed ✅"
}

error_handler() {
    echo "An error occurred. Exiting script. 😱"
    exit 1
}

trap error_handler ERR

main
