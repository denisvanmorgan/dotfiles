#!/bin/bash

source "$CONFIG_DIR/colors.sh"

OUTPUT=$("$CONFIG_DIR/helpers/fan") || exit 0
read -r RPM PERCENT <<< "$OUTPUT"

if [ "$RPM" -eq 0 ]; then
  LABEL="Off" COLOR=$OVERLAY1
elif [ "$PERCENT" -ge 85 ]; then
  LABEL="$RPM rpm" COLOR=$RED
elif [ "$PERCENT" -ge 60 ]; then
  LABEL="$RPM rpm" COLOR=$YELLOW
else
  LABEL="$RPM rpm" COLOR=$BLUE
fi

sketchybar --set "$NAME" label="$LABEL" icon.color=$COLOR
