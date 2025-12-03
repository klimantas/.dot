# !/bin/sh
# call this script with a number as argument to switch to 
# corresponding window in that space

# query the current windows in the current space
# current_windows=$(yabai -m query --windows --space | jq -r '.[].id')
# current windows return lines of windows id

# get the argument space number
# target_window=$1

# focus the window current_windows[$target_window]

# idx=$(($1))
# yabai -m window --focus "$(yabai -m query --windows --space \
#   | jq -r --argjson i "$idx" '.[ $i ].id')"

#!/usr/bin/env bash
# xyz.sh

set -euo pipefail

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <1-based-index>" >&2
  exit 1
fi

idx="$1"

# convert to zero‐based index for jq
zb=$(( idx - 1 ))

# query, sort by .id ascending, then pick the zero‐based element and extract its id
win_id=$(
  yabai -m query --windows id --space |
    jq -r --argjson i "$zb" '
      sort_by(.id)       # sort the array by numeric .id
      | .[$i].id         # pick element i
    '
)

# if jq returned null or empty, it was out of range
if [ -z "$win_id" ] || [ "$win_id" = "null" ]; then
  echo "No window at position $idx (after sorting)" >&2
  exit 2
fi

# focus it
yabai -m window --focus "$win_id"
