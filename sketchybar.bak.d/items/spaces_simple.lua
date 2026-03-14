local colors = require("colors")

local space_indicator = sbar.add("item", {
  position = "left",
  icon = {
    string = "1",
    -- color = colors.accent,
    font = {
      size = 12.0,
    },
  },
  background = {
    -- height = 20,
    -- corner_radius = 3,
    -- color = colors.background,
    -- border_color = colors.foreground_2,
    -- border_width = 1,
  },
--   padding_left = -10 ,
--   padding_right = 2,
  label = {
    drawing = false,
  },
})

local function update_space_indicator()
  -- Get current space and total count - simpler approach
  sbar.exec("current=$(yabai -m query --spaces --space | jq -r '.index'); total=$(yabai -m query --spaces | jq 'length'); echo \"$current/$total\"", function(output)
    local result = output:gsub("%s+", "")
    if result and result ~= "" then
      space_indicator:set({
        icon = {
          string = result,
        }
      })
    end
  end)
end

local function mouse_click(env)
  if env.BUTTON == "right" then
    -- Right click: Create new space
    sbar.exec("yabai -m space --create", function()
      update_space_indicator()
    end)
elseif env.BUTTON == "left" then
    -- Left click: Show space overview (mission control style)
    sbar.exec("open -b com.apple.exposelauncher")
  end
end

-- Subscribe to space changes
space_indicator:subscribe("space_change", update_space_indicator)
space_indicator:subscribe("mouse.clicked", mouse_click)

-- Initial update
update_space_indicator()
