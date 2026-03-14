-- get colors
local colors = require("colors")


local cal = sbar.add("item", {
  name = "calendar",
  icon = {
    -- string = "􀐫",
    -- drawing = false,
    -- padding_right = 0,
    -- font = {
    --   style = "Black",
    --   size = 12.0,
    -- },
  },
  -- label = {
  --   width = 45,
  --   align = "right",
  -- },
  background = {
    -- color = colors.color_1,
    corner_radius = 3,
    height = 20,
  },
  position = "right",
  update_freq = 15,
  padding_left = 10,
  padding_right = -8,
  y_offset = 8,  -- Move clock up
})

-- sketchybar --set "$NAME" label="$(date '+%d/%m %I:%M %p')"

local function update()
  -- local date = os.date("%a. %d %b.")
  local time = os.date("%d/%m %I:%M %p")
  cal:set({label=time})
end

cal:subscribe("routine", update)
cal:subscribe("forced", update)
cal:subscribe("mouse.clicked", function(_)
  sbar.exec("skhd -k 'fn - n'")
end)
