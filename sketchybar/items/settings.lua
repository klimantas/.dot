-- get colors
local colors = require("colors")

local settings = sbar.add("item", {
  icon = {
    string = "􀣋", -- gear/settings icon
    -- padding_right = 8,
  },
  label = {
    drawing = false,
  },
  background = {
    corner_radius = 3,
    height = 20,
  },
  position = "right",
  padding_right = -8,
  padding_left = 6,
})

-- When clicked, execute fn + c
settings:subscribe("mouse.clicked", function(_)
  sbar.exec("skhd -k 'fn - c'")
end)
