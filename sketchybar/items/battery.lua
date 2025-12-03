-- local icons = require("icons")
local colors = require("colors")
-- -------------------------------------------------------------------------- --
-- PERCENTAGE="$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)"
-- CHARGING="$(pmset -g batt | grep 'AC Power')"

-- if [ "$PERCENTAGE" = "" ]; then
--   exit 0
-- fi

-- case "${PERCENTAGE}" in
--   9[0-9]|100) ICON="􀛨"
--   ;;
--   [6-8][0-9]) ICON="􀺸"
--   ;;
--   [3-5][0-9]) ICON="􀺶"
--   ;;
--   [1-2][0-9]) ICON="􀛩"
--   ;;
--   *) ICON="􀛪"
-- esac

-- if [[ "$CHARGING" != "" ]]; then
--   ICON="􀢋"
-- fi

-- # The item invoking this script (name $NAME) will get its icon and label
-- # updated with the current battery status
-- sketchybar --set "$NAME" icon="$ICON" label="${PERCENTAGE}%"


local battery = sbar.add("item", {
  position = "right",
--  icon = {
--  },
  label = {

  },
  background = {
    -- color = colors.color_4,
    corner_radius = 3,
    height = 20,
  },
  update_freq = 120,
})

local function battery_update()
  sbar.exec("pmset -g batt", function(batt_info)
    local icon = "!"

    if (string.find(batt_info, 'AC Power')) then
      local found, _, charge = batt_info:find("(%d+)%%")
      if found then
        charge_str = charge .. "%"
        charge = tonumber(charge)
      end
      -- icon = icons.battery.charging
      charge_str =  charge .. "%"
      -- charge = "AC"
    else
      local found, _, charge = batt_info:find("(%d+)%%")
      if found then
        charge_str = charge .. "%"
        charge = tonumber(charge)
      end

      if found and charge > 80 then
        icon = icons.battery._100
      elseif found and charge > 60 then
        icon = icons.battery._75
      elseif found and charge > 40 then
        icon = icons.battery._50
      elseif found and charge > 20 then
        icon = icons.battery._25
      else
        icon = icons.battery._0
      end
    end

    battery:set({ 
      icon = icon,
      label = charge_str ,
    } )
  end)
end


battery:subscribe({"routine", "power_source_change", "system_woke"}, battery_update)
-- battery:subscribe("mouse.clicked", function(_)
--   sbar.exec("skhd -k 'fn - c'")
-- end)
