#!/bin/bash
# determine current layout of space and set label and icon accordingly
LAYOUT=$(yabai -m query --spaces --space | jq -r '.type')

# toggle between bsp and float and stack
case $LAYOUT in
  'bsp')
    yabai -m space --layout float
    ;;
  'float')
    yabai -m space --layout stack

    ;;
  'stack')

    yabai -m space --layout bsp
    ;;
esac

# Restore all windows to normal opacity when entering bsp or float layout
# NEW_LAYOUT=$(yabai -m query --spaces --space | jq -r '.type')
# if [[ "$NEW_LAYOUT" == "bsp" || "$NEW_LAYOUT" == "float" ]]; then
#     # yabai -m query --windows --space | jq -r '.[].id' | xargs -I {} yabai -m window {} --opacity 0.92
# elif [[ "$NEW_LAYOUT" == "stack" ]]; then
#     # Call border color script to handle stack opacity
#     ~/.config/yabai/update_border_color.sh
# fi

# send an event to sketchybar to update the layout icon event_custom_layout_changed
sketchybar --trigger event_custom_layout_changed
