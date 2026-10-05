#!/bin/bash

source "$CONFIG_DIR/colors.sh"

TEMP=$("$CONFIG_DIR/helpers/temp") || exit 0

if [ "$TEMP" -ge 90 ]; then
  COLOR=$RED
elif [ "$TEMP" -ge 75 ]; then
  COLOR=$YELLOW
else
  COLOR=$SKY
fi

sketchybar --set "$NAME" label="${TEMP}°C" icon.color=$COLOR
