#!/bin/bash

source "$CONFIG_DIR/colors.sh"
source "$CONFIG_DIR/notification_apps.sh"

case "$SENDER" in
  mouse.exited.global)   sketchybar --set "$NAME" popup.drawing=off; exit 0 ;;
  notification_received) sleep 1 ;; # give the app a moment to update its Dock badge
esac

# "lsappinfo info -only StatusLabel" is broken on macOS 27, so the Dock badge is picked out of
# the full record: "StatusLabel"={ "label"="3" }. Apps without one there (Messages) fall back
# to the badge count they logged, see helpers/notification_watch.sh.
BADGE_RE='"StatusLabel"=\{ "label"="([^"]+)"'

total=0 badged=0 args=()
for entry in "${NOTIFICATION_APPS[@]}"; do
  app="${entry%%|*}" badge=""
  if [[ $(lsappinfo info -long -app "$app") =~ $BADGE_RE ]]; then
    badge="${BASH_REMATCH[1]}"
  elif [ -f "$NOTIFICATION_BADGES/$app" ]; then
    read -r badge < "$NOTIFICATION_BADGES/$app"
    [ "$badge" = 0 ] && badge=""
  fi
  if [ -z "$badge" ]; then
    args+=(--set "$NAME.$app" drawing=off)
    continue
  fi
  digits="${badge//[^0-9]/}" # Mail groups thousands ("1 098")
  [ -n "$digits" ] && total=$((total + 10#$digits))
  badged=$((badged + 1))
  args+=(--set "$NAME.$app" drawing=on label="${entry#*|}  $badge")
done

if [ $badged -eq 0 ]; then
  args+=(--set "$NAME" icon=􀋙 icon.color=$OVERLAY1 label.drawing=off
         --set "$NAME.none" drawing=on)
else
  # Slack badges unread channels without mentions with a bare "•", so there may be no number
  [ $total -gt 0 ] && count=(label="$total" label.drawing=on) || count=(label.drawing=off)
  args+=(--set "$NAME" icon=􀝗 icon.color=$RED "${count[@]}"
         --set "$NAME.none" drawing=off)
fi

sketchybar "${args[@]}"
