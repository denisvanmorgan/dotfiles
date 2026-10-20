#!/bin/bash

source "$CONFIG_DIR/notification_apps.sh"
source "$PLUGIN_DIR/icon_map.sh"

# Badges of the apps in notification_apps.sh are totalled on the bell and listed in its popup
POPUP_OFF="sketchybar --set notifications popup.drawing=off"
WATCHER="$CONFIG_DIR/helpers/notification_watch.sh"

# First item of the status pill (left of the battery)
sketchybar --add event notification_received \
           --add item notifications right \
           --set notifications update_freq=5 \
                               icon=􀋙 \
                               icon.color=$OVERLAY1 \
                               icon.padding_left=12 \
                               label.drawing=off \
                               click_script="sketchybar --set notifications popup.drawing=toggle" \
                               script="$PLUGIN_DIR/notifications.sh" \
                               popup.align=right \
                               "${POPUP[@]}" \
           --subscribe notifications notification_received system_woke mouse.exited.global

for entry in "${NOTIFICATION_APPS[@]}"; do
  app="${entry%%|*}"
  __icon_map "${entry#*|}"
  sketchybar --add item "notifications.$app" popup.notifications \
             --set "notifications.$app" "${MENU_ITEM[@]}" \
                                        drawing=off \
                                        icon="$icon_result" \
                                        icon.font="$APP_FONT:15.0" \
                                        click_script="$POPUP_OFF; open -b $app" \
                                        script="$PLUGIN_DIR/menu_hover.sh" \
             --subscribe "notifications.$app" mouse.entered mouse.exited
done

sketchybar --add item notifications.none popup.notifications \
           --set notifications.none "${MENU_ITEM[@]}" \
                                    icon=􀋝 \
                                    icon.color=$OVERLAY1 \
                                    label="No notifications" \
                                    label.color=$SUBTEXT0

sketchybar --add bracket status notifications battery calendar \
           --set status "${PILL[@]}"

# Refreshes the bell as soon as one of the apps notifies or changes its badge (restarted on every config load)
pkill -f "$WATCHER"
"$WATCHER" > /dev/null 2>&1 &
