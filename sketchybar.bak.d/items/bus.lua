local colors = require("colors")
-- TIME=$(curl -s 'https://maps.trilliumtransit.com/gtfsmap-realtime/feed/dartmouth-vt-us/arrivals?stopCode=4206789&stopID=4206789' | jq -r '.data[] | select(.route_id == "76431") | .formattedTime' | head -n 1)
-- sketchybar --set "bus_track" label="Sachem: $TIME"

-- local cal = sbar.add("item", {
--   icon = {
--     -- padding_right = 0,
--     -- font = {
--     --   style = "Black",
--     --   size = 12.0,
--     -- },
--   },
--   -- label = {
--   --   width = 45,
--   --   align = "right",
--   -- },
--   position = "right",
--   update_freq = 15,
-- })

-- local function update()
--   local date = os.date("%a. %d %b.")
--   local time = os.date("%H:%M")
--   cal:set({ icon = date, label = time })
-- end

-- cal:subscribe("routine", update)
-- cal:subscribe("forced", update)


-- set bus_track  icon=􀝉 script="$PLUGIN_DIR/bus_track.sh" "${background[@]}" update_freq=60 background.color=${COLOR_5} \
-- background=(
--   background.color=${COLOR_3}
--   background.corner_radius=3
--   background.height=20
-- )
local bus = sbar.add("item", {
--[[
  icon = {
    string = "􀝉",
    -- align = "left",
  },
  label = {
    string = "Sachem: $TIME",
    width = 45,
    align = "left",
    padding_left = 5,
   },
--]]
  position = "right",
  update_freq = 10,
  background = {
    -- color = colors.color_5,
    corner_radius = 3,
    height = 20,
  },
  padding_right = -20,
})

local function update()
  local cmd = "curl -s 'https://maps.trilliumtransit.com/gtfsmap-realtime/feed/dartmouth-vt-us/arrivals?stopCode=4206789&stopID=4206789' | jq -r '.data[] | select(.route_id == \"76431\") | .formattedTime' | head -n 1"
  sbar.exec(cmd, function(output)
    sbar.set(bus.name, {
      label = "Sachem: " ..output,
    })
  end)
end

bus:subscribe("routine", update)
bus:subscribe("forced", update)
