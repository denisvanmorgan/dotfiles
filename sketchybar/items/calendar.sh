#!/bin/bash

sketchybar --add item calendar right \
           --set calendar update_freq=10 \
                          icon=􀧞 \
                          icon.color=$LAVENDER \
                          label.padding_right=12 \
                          click_script="open -a Calendar" \
                          script="$PLUGIN_DIR/calendar.sh"
