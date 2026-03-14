#!/bin/sh
# change label

# yabai
# get number of windows in current space to variable NUM_WINDOWS

NUM_WINDOWS=$(yabai -m query --spaces --space | jq '.windows | length')
NUM_SPACES=$(yabai -m query --spaces | jq '. | length')

# for each space, get the number of windows in that space.
# if the number of window is 0, set the label of that space to "E"
# else dont do anything

for i in $(seq 1 $NUM_SPACES);
do
  NUM_WINDOWS=$(yabai -m query --spaces --space $i | jq '.windows | length')
  if [ $NUM_WINDOWS -eq 0 ]; then
    sketchybar --set "space.$i" icon.color=0x45ffffff
  else
    sketchybar --set "space.$i" icon.color=0xffffffff
  fi
done
# sketchybar --set "$NAME" label="$NUM_WINDOWS"