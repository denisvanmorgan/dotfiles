#!/bin/bash

LOCK="$CONFIG_DIR/helpers/lock"
POPUP_OFF="sketchybar --set apple popup.drawing=off"

# Lives inside the workspaces pill (see the spaces bracket in items/spaces.sh)
sketchybar --add item apple left \
           --set apple icon=􀣺 \
                       icon.font="$FONT:Semibold:15.0" \
                       icon.color=$ACCENT_COLOR \
                       icon.padding_left=10 \
                       icon.padding_right=7 \
                       label.drawing=off \
                       click_script="sketchybar --set apple popup.drawing=toggle" \
                       script="$POPUP_OFF" \
                       popup.align=left \
                       popup.height=30 \
                       popup.background.color=$PILL_COLOR \
                       popup.background.border_color=$PILL_BORDER_COLOR \
                       popup.background.border_width=1 \
                       popup.background.corner_radius=8 \
           --subscribe apple mouse.exited.global

menu_item() { # <name> <icon> <label> <command>
  sketchybar --add item "apple.$1" popup.apple \
             --set "apple.$1" icon="$2" \
                              label="$3" \
                              icon.color=$ACCENT_COLOR \
                              icon.width=36 \
                              icon.align=center \
                              icon.padding_left=0 \
                              icon.padding_right=0 \
                              label.padding_left=0 \
                              label.padding_right=12 \
                              padding_left=3 \
                              padding_right=3 \
                              width=152 \
                              background.color=$ACCENT_COLOR \
                              background.height=24 \
                              background.corner_radius=5 \
                              background.drawing=off \
                              click_script="$POPUP_OFF; $4" \
                              script="$PLUGIN_DIR/menu_hover.sh" \
             --subscribe "apple.$1" mouse.entered mouse.exited
}

menu_item about    􀅴 "About This Mac"   "open '/System/Library/CoreServices/Applications/About This Mac.app'"
menu_item settings 􀣋 "System Settings"  "open -a 'System Settings'"
menu_item activity 􀑁 "Activity Monitor" "open -a 'Activity Monitor'"
menu_item lock     􀎠 "Lock Screen"      "'$LOCK'"
menu_item sleep    􀆹 "Sleep"            "pmset sleepnow"
