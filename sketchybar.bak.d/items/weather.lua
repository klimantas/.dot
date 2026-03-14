local colors = require("colors")

local weather = sbar.add("item", {
  name = "weather",
  position = "right",
  update_freq = 60,
  background = {
    -- color = colors.color_4,
    corner_radius = 3,
    height = 20,
  },
  y_offset = -8,  -- Move weather down
  padding_right = -90,  -- Move further to the right
  padding_left  = 0, 
})

local function update()
  local cmd = "curl -s wttr.in/?format=1"
  sbar.exec(cmd, function(output)
    -- set max char length
    output = output:sub(1, 15)  -- limit character length
    weather:set({
      label = output,
    })
  end)
end

weather:subscribe("routine", update)
weather:subscribe("forced", update)

-- sketchybar --add item test right \                                                         1 ↵
--   --set test scroll_texts=on \
--   max_chars=5 \
--   label="This is a long test text that should scroll"
-- -- sketchybar --set test label.max_chars=5

-- sbar.add("item", "test", {
--   position = "right",
--   scroll_texts = true,
--   label = {
--     string = "This is a long test text that should scroll",
--     max_chars = 5,
--     scroll_duration = 150,
--     width = 100,
--     highlight_color = colors.magenta,
--     highlight = true,
--   },
--   icon = {
--     string = "􀇂",
--   },
--   background = {
--     color = colors.color_background,
--     height = 20,
--     corner_radius = 3,
--     border_width = 1,
--   },
-- })
