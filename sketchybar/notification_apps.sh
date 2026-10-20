#!/bin/bash

# Apps on the notification bell as "<bundle id>|<name>" (the name also picks the icon from icon_map.sh)
NOTIFICATION_APPS=("com.tinyspeck.slackmacgap|Slack"
                   "com.apple.mail|Mail"
                   "com.apple.MobileSMS|Messages")

# Badge counts of apps whose Dock badge lsappinfo can't see (Messages), as logged by the app
# and collected by helpers/notification_watch.sh: one file per bundle id holding the count
NOTIFICATION_BADGES="$HOME/.cache/sketchybar/notification_badges"
