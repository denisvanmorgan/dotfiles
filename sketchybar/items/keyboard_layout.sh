#!/bin/bash

sketchybar --add item keyboard_layout center \
           --set keyboard_layout update_freq=1 \
                      icon="󰌌" \
                      script="$PLUGIN_DIR/keyboard_layout.sh"
