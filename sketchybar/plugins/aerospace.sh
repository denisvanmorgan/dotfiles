#!/bin/bash

source "$CONFIG_DIR/colors.sh"
source "$CONFIG_DIR/plugins/icon_map.sh"

FOCUSED="${AEROSPACE_FOCUSED_WORKSPACE:-$(aerospace list-workspaces --focused)}"
VISIBLE=$'\n'"$(aerospace list-workspaces --monitor all --visible)"$'\n'

# Collect de-duplicated app icons per workspace into $icons_<workspace>
while IFS='|' read -r ws app; do
  [ -z "$ws" ] && continue
  __icon_map "$app"
  var="icons_${ws//[^a-zA-Z0-9_]/_}"
  [[ " ${!var} " == *" $icon_result "* ]] || printf -v "$var" '%s %s' "${!var}" "$icon_result"
done <<< "$(aerospace list-windows --all --format '%{workspace}|%{app-name}')"

args=()
for ws in $(aerospace list-workspaces --all); do
  var="icons_${ws//[^a-zA-Z0-9_]/_}"
  icons="${!var# }"

  if [ "$ws" = "$FOCUSED" ]; then
    style=(drawing=on background.drawing=on background.color=$ACCENT_COLOR icon.color=$CRUST label.color=$CRUST)
  elif [[ "$VISIBLE" == *$'\n'"$ws"$'\n'* ]]; then
    style=(drawing=on background.drawing=on background.color=$SURFACE1 icon.color=$TEXT label.color=$TEXT)
  elif [ -n "$icons" ]; then
    style=(drawing=on background.drawing=off icon.color=$SUBTEXT0 label.color=$OVERLAY2)
  else
    style=(drawing=off)
  fi

  if [ -n "$icons" ]; then
    style+=(label="$icons" label.drawing=on icon.padding_right=4)
  else
    style+=(label.drawing=off icon.padding_right=10)
  fi

  args+=(--set "space.$ws" "${style[@]}")
done

sketchybar "${args[@]}"
