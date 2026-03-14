local colors = require("colors")


local function transparentize(color, transparency)
  -- Convert percentage (0-100) to alpha value (0-255)
  local alpha = math.floor((transparency / 100) * 255)
  -- Extract RGB components (remove alpha channel)
  local rgb = color & 0x00ffffff
  -- Combine with new alpha channel
  return (alpha << 24) | rgb
end

sbar.bar({
  height = 35,
  color = 0x00000000, -- Fully transparent so only the brackets show
  shadow = "off",
  blur_radius = 0,
  position = "top",
  sticky = "on",
  padding_right = 350, -- Your notification gap
  padding_left = 10,
})
