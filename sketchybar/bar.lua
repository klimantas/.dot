local colors = require("colors")


local function transparentize(color, transparency)
  -- Convert percentage (0-100) to alpha value (0-255)
  local alpha = math.floor((transparency / 100) * 255)
  -- Extract RGB components (remove alpha channel)
  local rgb = color & 0x00ffffff
  -- Combine with new alpha channel
  return (alpha << 24) | rgb
end


-- Equivalent to the --bar domain

-- sbar.bar({
--   height = 40,
--   color = colors.bar.bg,
--   border_color = colors.bar.border,
--   shadow = true,
--   sticky = true,
--   padding_right = 10,
--   padding_left = 10,
--   blur_radius=20,
--   topmost="window",
-- })

-- -sketchybar --bar topmost=off position=top height=38 blur_radius=30 color=0xff000000  
sbar.bar({
  position = "top",
  y_offset = 24,
  height = 38,
  color = transparentize(colors.background, colors.transparency),
  topmost="on",
  -- border_color = colors.bar.border,
  -- shadow = true,
  -- sticky = false,
  -- padding_right = 10,
  -- padding_left = 10,
  blur_radius=30,
  notch_width=200,
})
