-- require("bar")
-- sbar = require("sketchybar")
-- require
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
local lock = sbar.add("item", {
  padding_right = -14,
  padding_left = 6,
  position = "right",
  icon = {
    -- string = "􀎠",
    -- padding_right = 8,
    -- drawing = false,
  },
  label = {
    -- drawing = false,
    -- string = "Sachem: $TIME",
    -- width = 45,
    -- align = "left",
    drawing = false,
  },
  position = "right",
  background = {
    -- color = colors.color_5,
    corner_radius = 3,
    height = 20,
  },
})

-- local function log_table(t)
--   local log_file = os.getenv("HOME") .. "/Desktop/bar.log"
--   local file = io.open(log_file, "a")
--   -- write timestamp + msg
--   -- log every key value
--   for k, v in pairs(t) do
--     file:write(os.date("%Y-%m-%d %H:%M:%S") .. "-" .. k .. ": " .. tostring(v) .. "\n")
--   end
-- end

local update = function(is_clicked)
  local locked = sbar.query("bar")["topmost"]
  local icon
  if locked == "off" then
    icon = "􀎤"
  else
    icon = "􀎠"
  end
  -- if locked == "off" then
  --   icon = "􀎤"
  -- else
  --   icon = "􀎠"
  -- end

  lock:set({ 
    icon = {
        string = icon,
        padding_right = 8,
    },
    -- label = {
    --   string = output,
    --   drawing = true,
    -- },

  })


  -- end)
end

local function toggle_lock()
  local locked = sbar.query("bar")["topmost"]
  if locked == "off" then
    sbar.bar({ topmost = "on" })
    sbar.exec("toptop_bar --bar topmost=on")
  else
    sbar.bar({ topmost = "off" })
    sbar.exec("toptop_bar --bar topmost=off")
  end
  update()
end

lock:subscribe("mouse.clicked", toggle_lock)
lock:subscribe("forced", update)
