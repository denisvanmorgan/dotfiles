#!/bin/bash

SELECTED_LAYOUT=$(defaults read com.apple.HIToolbox AppleSelectedInputSources | grep "KeyboardLayout Name" | sed -E 's/.*"KeyboardLayout Name" = "(.*)";/\1/')

sketchybar --set $NAME label="$SELECTED_LAYOUT"
