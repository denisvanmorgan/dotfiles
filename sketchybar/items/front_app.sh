#!/bin/bash

sketchybar --add item front_app q \
           --set front_app "${PILL[@]}" \
                           icon.font="$APP_FONT:15.0" \
                           icon.color=$ACCENT_COLOR \
                           icon.padding_left=12 \
                           icon.padding_right=6 \
                           label.padding_left=0 \
                           label.padding_right=12 \
                           script="$PLUGIN_DIR/front_app.sh" \
           --subscribe front_app front_app_switched \
                                 aerospace_workspace_change \
                                 aerospace_focus_change
