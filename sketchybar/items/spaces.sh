#!/bin/bash

# Triggered from aerospace.toml (exec-on-workspace-change / on-focus-changed)
sketchybar --add event aerospace_workspace_change \
           --add event aerospace_focus_change

# Every AeroSpace workspace gets an item; plugins/aerospace.sh decides which
# ones are drawn (focused, visible on a monitor, or holding windows).
for ws in $(aerospace list-workspaces --all 2>/dev/null); do
  sketchybar --add item "space.$ws" left \
             --set "space.$ws" drawing=off \
                               padding_left=3 \
                               padding_right=3 \
                               icon="$ws" \
                               icon.font="$FONT:Bold:12.0" \
                               icon.padding_left=10 \
                               icon.padding_right=10 \
                               label.font="$APP_FONT:14.0" \
                               label.padding_left=0 \
                               label.padding_right=10 \
                               label.y_offset=-1 \
                               background.color=$ACCENT_COLOR \
                               background.height=20 \
                               background.corner_radius=5 \
                               background.drawing=off \
                               click_script="aerospace workspace $ws"
done

sketchybar --add bracket spaces apple '/space\..*/' \
           --set spaces "${PILL[@]}"

sketchybar --add item aerospace left \
           --set aerospace drawing=off \
                           updates=on \
                           script="$PLUGIN_DIR/aerospace.sh" \
           --subscribe aerospace aerospace_workspace_change \
                                 aerospace_focus_change \
                                 front_app_switched \
                                 space_windows_change \
                                 display_change \
                                 system_woke
