#!/bin/bash

sketchybar --add item temp e \
           --set temp update_freq=5 \
                      icon=􀇬 \
                      icon.color=$SKY \
                      script="$PLUGIN_DIR/temp.sh"
