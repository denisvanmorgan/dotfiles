#!/bin/bash

sketchybar --add item cpu e \
           --set cpu update_freq=3 \
                     icon=􀧓 \
                     icon.color=$TEAL \
                     icon.padding_left=12 \
                     script="$PLUGIN_DIR/cpu.sh"
