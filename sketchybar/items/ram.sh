#!/bin/bash

sketchybar --add item ram e \
           --set ram update_freq=10 \
                     icon=􀫦 \
                     icon.color=$SAPPHIRE \
                     label.padding_right=12 \
                     script="$PLUGIN_DIR/ram.sh"

sketchybar --add bracket stats cpu temp fan ram \
           --set stats "${PILL[@]}"
