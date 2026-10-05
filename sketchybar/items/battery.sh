#!/bin/bash

sketchybar --add item battery right \
           --set battery update_freq=120 \
                         icon.padding_left=12 \
                         script="$PLUGIN_DIR/battery.sh" \
           --subscribe battery system_woke power_source_change

sketchybar --add bracket status battery calendar \
           --set status "${PILL[@]}"
