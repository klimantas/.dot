#!/bin/sh

# this script receive a number as argument and focus the space with that number
# if the current space and the argument space is in same display, simply use focus to switch
# yabai -m space --focus 9
# else, use the swap command, and then focus
# yabai -m space --swap 7; yabai -m space --focus 9

# get the current space number
current_space=$(yabai -m query --spaces --space | jq -r '.index')

# get the argument space number
space_number=$1

echo $current_space
echo $space_number

# get the current display id
current_display=$(yabai -m query --displays --display | jq -r '.index')

# get the display id of the argument space
space_display=$(yabai -m query --spaces --space $space_number | jq -r '.display')

# if the current space and the argument space is in same display

if [ $current_display -eq $space_display ]; then
    yabai -m space --focus $space_number
else
    # yabai -m space --swap  $space_number
    yabai -m space --focus $space_number
fi

sketchybar  --trigger event_custom_windows_changed
sketchybar  --trigger space_change
