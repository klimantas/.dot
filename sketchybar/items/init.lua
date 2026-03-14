local colors = require("colors")

-- Current app bracket
require("items.spaces_simple")
require("items.front_app")
sbar.add("bracket", "left_info_bracket", {
  "spaces_simple",
  "front_app"
}, {
  background = {
    -- color = colors.bg,
    color = 0xff24273a,         -- Hardcoded dark gray
    border_color = 0xffffffff,
    border_width = 1,
    corner_radius = 9,
    height = 25
  },
  padding_left = 10,
  padding_right = 10
})

-- Open apps bracket
require("items.apps")

-- Right widgets bracket
require("items.battery")
require("items.weather")
require("items.bus")
require("items.volume")
sbar.add("bracket", "right_widgets_bracket", {
  "battery",
  "weather",
  "bus",
  "volume"
}, {
  background = {
    color = 0xff24273a,         -- Hardcoded dark gray
    border_color = 0xffffffff,  -- Hardcoded white
    border_width = 1,
    corner_radius = 9,
    height = 22
  },
  padding_left = 10,
  padding_right = 10
})
