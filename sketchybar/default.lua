local settings = require("settings")
local colors = require("colors")

sbar.default({
  -- padding_left = 5,
  -- padding_right = 5,
  icon = {
    font = {
      family = settings.font,
      style = "Regular",
      size = 10.0
    },
    color = colors.accent,
    padding_left = 6,
    padding_right = 3,
  },
  label = {
    font = {
      family = settings.font,
      -- family = settings.text_font,
      style = "Bold",
      size = 11.0
    },
    color = colors.foreground,
    padding_left = 3,
    padding_right = 6,
  },
  y_offset = 0,
})

-- add event event_custom_windows_changed
sbar.add("event", "event_custom_windows_changed")
sbar.add("event", "event_custom_layout_changed")
