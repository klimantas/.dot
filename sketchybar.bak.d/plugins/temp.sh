# wttr temp in boston
TEMP=$(curl -s wttr.in/~Hanover+NH?format="%t")
sketchybar --set "temp" label="Boston: $TEMP"