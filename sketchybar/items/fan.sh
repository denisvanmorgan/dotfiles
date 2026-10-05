#!/bin/bash

sketchybar --add item fan e \
           --set fan update_freq=5 \
                     icon=􁒚 \
                     icon.color=$BLUE \
                     script="$PLUGIN_DIR/fan.sh"
