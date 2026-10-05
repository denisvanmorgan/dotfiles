#!/bin/bash

source "$CONFIG_DIR/colors.sh"

if [ "$SENDER" = "mouse.entered" ]; then
  sketchybar --set "$NAME" background.drawing=on icon.color=$CRUST label.color=$CRUST
else
  sketchybar --set "$NAME" background.drawing=off icon.color=$ACCENT_COLOR label.color=$TEXT
fi
