#!/bin/bash

source "$CONFIG_DIR/colors.sh"

# "Memory Used" as in Activity Monitor: app memory + wired + compressed
USED=$(vm_stat | awk -v total="$(sysctl -n hw.memsize)" '
  /page size of/                { page = $8 }
  /^Anonymous pages/            { anon = $3 }
  /^Pages purgeable/            { purgeable = $3 }
  /^Pages wired down/           { wired = $4 }
  /^Pages occupied by compressor/ { compressed = $5 }
  END { printf "%.0f", (anon - purgeable + wired + compressed) * page / total * 100 }')

if [ "$USED" -ge 85 ]; then
  COLOR=$RED
elif [ "$USED" -ge 70 ]; then
  COLOR=$YELLOW
else
  COLOR=$SAPPHIRE
fi

sketchybar --set "$NAME" label="$USED%" icon.color=$COLOR
