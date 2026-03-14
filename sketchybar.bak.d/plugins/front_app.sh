#!/bin/sh

# Some events send additional information specific to the event in the $INFO
# variable. E.g. the front_app_switched event sends the name of the newly
# focused application in the $INFO variable:
# https://felixkratz.github.io/SketchyBar/config/events#events-and-scripting

if [ "$SENDER" = "front_app_switched" ]; then

  WINDOWS=$(yabai -m query --windows --space | jq -r '.[] |  .id')
  WINDOWS_APP=$(yabai -m query --windows --space | jq -r '.[] |  .app')
  # convert \n to 4 spaces
  WINDOWS_APP=$(printf "%s\n" "${WINDOWS_APP[@]}" | tr '\n' ' ')
  

  sketchybar --set "$NAME" label="$WINDOWS_APP"
  # sketchybar --set "$NAME" label="$SHELL"

  # query the list of windows in yabai stack layout

  # # for each in WINDOWS string seperated by new line, echo
  


  # WINDOWS_TITLE=$(yabai -m query --windows --space | jq -r '.[] |  .title')
  # # check if focused by .has-focus
  # WINDOWS_FOCUS=($(yabai -m query --windows --space | jq -r '.[] |  ."has-focus"'))

  # # for loop to make that string
  # for i in $(seq 0 $(${#WINDOWS_FOCUS[@]} - 1)); do
  #   echo "${WINDOWS_FOCUS[$i]}" 
  #   if [ "${WINDOWS_FOCUS[$i]}" = "true" ]; then
  #     WINDOWS_APP[$i]="* ${WINDOWS_APP[$i]}"
  #   fi
  # done
  # WINDOWS_APP=$(printf "%s\n" "${WINDOWS_APP[@]}" | tr '\n' ' ')



fi







