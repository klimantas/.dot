local settings = require("settings")
local colors = require("colors")

-- Equivalent to the --default domain
-- sbar.default({
--   updates = "when_shown",
--   icon = {
--     font = {
--       family = settings.font,
--       style = "Bold",
--       size = 14.0
--     },
--     color = colors.white,
--     padding_left = settings.paddings,
--     padding_right = settings.paddings,
--   },
--   label = {
--     font = {
--       family = settings.font,
--       style = "Semibold",
--       size = 13.0
--     },
--     color = colors.white,
--     padding_left = settings.paddings,
--     padding_right = settings.paddings,
--   },
--   background = {
--     height = 26,
--     corner_radius = 9,
--     border_width = 2,
--   },
--   popup = {
--     background = {
--       border_width = 2,
--       corner_radius = 9,
--       border_color = colors.popup.border,
--       color = colors.popup.bg,
--       shadow = { drawing = true },
--     },
--     blur_radius = 20,
--   },
--   padding_left = 5,
--   padding_right = 5
-- })

-- default=(
--   padding_left=5
--   padding_right=5
--   icon.font="SF Pro:Bold:10.0"
--   label.font="SF Pro:Bold:10.0"
--   icon.color=$FOREGROUND_COLOR
--   label.color=$FOREGROUND_COLOR
--   icon.padding_left=6
--   label.padding_left=3
--   icon.padding_right=3
--   label.padding_right=6
--   y_offset=-5
-- )
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
