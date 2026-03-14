#!/bin/sh

# The $SELECTED variable is available for space components and indicates if
# the space invoking this script (with name: $NAME) is currently selected:
# https://felixkratz.github.io/SketchyBar/config/components#space----associate-mission-control-spaces-with-an-item

# if the space is in second display, set text color to red
# using $NAME to query the display from yabai

# DISPLAY=$(yabai -m query --spaces --space "$NAME" | jq -r '.display')

# if [ "$DISPLAY" -eq 2 ]; then
#   sketchybar --set "$NAME" text.color="#FF0000"
# else
#   sketchybar --set "$NAME" text.color="#FFFFFF"
# fi

sketchybar --set "$NAME" background.drawing="$SELECTED" 
