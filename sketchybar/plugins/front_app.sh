#!/bin/bash

source "$CONFIG_DIR/plugins/icon_map.sh"

# front_app_switched passes the app name in $INFO; on forced updates ask AeroSpace
APP="${INFO:-$(aerospace list-windows --focused --format '%{app-name}' 2>/dev/null)}"

if [ -z "$APP" ]; then
  sketchybar --set "$NAME" drawing=off
  exit 0
fi

__icon_map "$APP"
sketchybar --set "$NAME" drawing=on icon="$icon_result" label="$APP"
