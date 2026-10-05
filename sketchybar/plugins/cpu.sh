#!/bin/bash

source "$CONFIG_DIR/colors.sh"

CORES=$(sysctl -n hw.logicalcpu)
LOAD=$(ps -A -o %cpu= | awk -v cores="$CORES" '{ s += $1 } END { p = s / cores; printf "%.0f", (p > 100 ? 100 : p) }')

if [ "$LOAD" -ge 85 ]; then
  COLOR=$RED
elif [ "$LOAD" -ge 60 ]; then
  COLOR=$YELLOW
else
  COLOR=$TEAL
fi

sketchybar --set "$NAME" label="$LOAD%" icon.color=$COLOR
