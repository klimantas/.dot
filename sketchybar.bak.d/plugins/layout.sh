# /bin/sh
# determine current layout of space and set label and icon accordingly
LAYOUT=$(yabai -m query --spaces --space | jq -r '.type')
case $LAYOUT in
  'bsp')
    ICON="􀟻"
    ;;
  'float')
    ICON="􁎄"
    ;;
  'stack')
    ICON="􀏭"
    ;;
esac

# if stack layout, add number of windows in current space in the label eg. (3)
if [ $LAYOUT = "stack" ]; then
  NUM_WINDOWS=$(yabai -m query --spaces --space | jq '.windows | length')
  LAYOUT="$LAYOUT ($NUM_WINDOWS)"
fi

sketchybar --set "$NAME" icon="$ICON" label="$LAYOUT"