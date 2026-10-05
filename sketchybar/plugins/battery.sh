#!/bin/bash

source "$CONFIG_DIR/colors.sh"

BATT="$(pmset -g batt)"
PERCENT=$(grep -Eo '[0-9]+%' <<< "$BATT" | cut -d% -f1)

[ -z "$PERCENT" ] && exit 0

case $PERCENT in
  9[0-9]|100) ICON=􀛨 COLOR=$GREEN ;;
  [6-8][0-9]) ICON=􀺸 COLOR=$GREEN ;;
  [3-5][0-9]) ICON=􀺶 COLOR=$YELLOW ;;
  [1-2][0-9]) ICON=􀛩 COLOR=$PEACH ;;
  *)          ICON=􀛪 COLOR=$RED ;;
esac

[[ "$BATT" == *"AC Power"* ]] && ICON=􀢋 COLOR=$GREEN

sketchybar --set "$NAME" icon="$ICON" icon.color=$COLOR label="$PERCENT%"
