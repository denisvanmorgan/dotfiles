#!/bin/bash

# Fires the notification_received event the moment one of the bell's apps posts a notification
# or changes its badge count, so the bell doesn't wait for its next poll. Apps whose Dock badge
# lsappinfo can't see (Messages) log every badge change, which is kept in $NOTIFICATION_BADGES.
# Reads the system log, no permissions needed. Started (and restarted on every config load)
# by items/notifications.sh.

source "$CONFIG_DIR/notification_apps.sh"

APPS="($(IFS='|'; echo "${NOTIFICATION_APPS[*]%%|*}"))"
DELIVERED_RE="Delivering <NotificationRecord app:\"$APPS\""
BADGE_RE="\[$APPS\] Setting badge count to ([0-9]+)"
DELIVERED_LOG='process == "usernoted" AND eventMessage BEGINSWITH "Delivering"'
BADGE_LOG='subsystem == "com.apple.UserNotifications" AND category == "Connections" AND eventMessage CONTAINS "Setting badge count to"'

save_badge() { [[ $1 =~ $BADGE_RE ]] && echo "${BASH_REMATCH[2]}" > "$NOTIFICATION_BADGES/${BASH_REMATCH[1]}"; }

FIFO="$(mktemp -u "${TMPDIR:-/tmp}/sketchybar_notifications.XXXXXX")"
mkfifo "$FIFO" || exit 1

/usr/bin/log stream --style compact --predicate "($DELIVERED_LOG) OR ($BADGE_LOG)" > "$FIFO" &
STREAM=$!
trap 'kill $STREAM 2> /dev/null; rm -f "$FIFO"' EXIT
trap 'exit 0' TERM INT HUP
exec 3< "$FIFO" # the stream waits in the pipe while the current badge counts are looked up

mkdir -p "$NOTIFICATION_BADGES"
/usr/bin/log show --style compact --last 7d --predicate "$BADGE_LOG" 2> /dev/null |
  while read -r line; do save_badge "$line"; done
sketchybar --trigger notification_received || exit 0

while read -r line <&3; do
  save_badge "$line" || [[ $line =~ $DELIVERED_RE ]] || continue
  sketchybar --trigger notification_received || exit 0 # sketchybar is gone
done
