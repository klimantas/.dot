local colors = require("colors")

local function mouse_click(env)
  if env.BUTTON == "right" then
    sbar.exec("yabai -m space --destroy " .. env.SID)
  else
    sbar.exec("yabai -m space --focus " .. env.SID)
  end
end

local function space_selection(env)
  -- local color = env.SELECTED == "true" and colors.white or colors.bg2
  local color = colors.white

  sbar.set(env.NAME, {
    -- icon = { highlight = env.SELECTED, font = {} },
    -- label = { highlight = env.SELECTED, },
    background = {
      color = env.SELECTED == "true" and colors.accent or colors.background,
    },
    icon = {
      color = env.SELECTED == "true" and colors.background or colors.accent,
    }
    
  })

 
end

-- -- make color more opague percentage, #ff -> #00 for example
local function make_opaque(color, percentage)
  -- local a, r, g, b = color:match("(%x%x)(%x%x)(%x%x)(%x%x)")
  -- color: #argb each 2 digits
  return color
end

local spaces = {}
for i = 1, 10, 1 do
  local space = sbar.add("space", {
    associated_space = i,
    icon = {
      string = i,
      padding_left = 4,
      padding_right = 4,
      -- color = make_opaque(colors.white, 0.5),
      -- highlight_color = colors.black,
    },

    background = {
      height = 16,
      corner_radius = 3,
    },

    padding_left = (i == 1) and -10 or 2,
    -- padding_left = 2,
    padding_right = 2,
    label = {
      -- padding_right = 20,
      -- color = colors.grey,
      -- highlight_color = colors.white,
      -- font = "sketchybar-app-font:Regular:16.0",
      -- y_offset = -1,
      drawing = false,
    },
  })

  spaces[i] = space.name
  space:subscribe("space_change", space_selection)
  space:subscribe("mouse.clicked", mouse_click)
end

sbar.add("bracket", spaces, {
  background = { color = colors.background, border_color = colors.foreground_2}
})

-- local space_creator = sbar.add("item", {
--   padding_left=0,
--   padding_right=0,
--   icon = {
--     string = "+",
--     font = {
--       -- style = "Heavy",
--       -- size = 16.0,
--     },
--   },
--   label = { 
--     drawing = false,
--   -- padding_left = 0,
--   -- padding_right = 0,
--   },
--   associated_display = "active",
-- })

-- space_creator:subscribe("mouse.clicked", function(_)
--   sbar.exec("yabai -m space --create")
-- end)
