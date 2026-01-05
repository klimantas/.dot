local colors = require("colors")
local icons = require("icons")

local volume_slider = sbar.add("slider", 100, {
  position = "right",
  padding_left = 0,
  padding_right = 0,
  updates = true,
  icon = {
    padding_right = 2,
    -- font = {
    --   style = "Black",
    --   size = 12.0,
    -- },
  },
  background = {
    -- color = colors.color_2,
    corner_radius = 3,
    height = 20,
  },
  slider = {
    highlight_color = colors.accent,
    width = 60,
    background = {
      height = 6,
      corner_radius = 3,
      color = colors.black
    },
    -- knob = {
    --   string = "􀀁",
    --   drawing = false,
    -- },
  },
})

volume_slider:subscribe("mouse.clicked", function(env)
  sbar.exec("osascript -e 'set volume output volume " .. env["PERCENTAGE"] .. "'")
end)

volume_slider:subscribe("volume_change", function(env)
  local volume = tonumber(env.INFO)
  if not volume then return end  -- Guard against nil values
  
  sbar.exec("SwitchAudioSource -c", function(output)
    local icon = icons.volume._0  -- Default icon
    
    if string.find(output, "MacBook") then
      icon = icons.volume.all
      --[[
      if volume > 60 then
        icon = icons.volume._100
      elseif volume > 30 then
        icon = icons.volume._66
      elseif volume > 10 then
        icon = icons.volume._33
      elseif volume > 0 then
        icon = icons.volume._10
      else
        icon = icons.volume._0
      end
      ]]
    else
      icon = icons.headphone
    end
    
    -- Combine the set() calls
    volume_slider:set({
      icon = { string = icon },
      slider = { percentage = volume }
    })
  end)
end)

-- Uncomment if you want the expandable slider feature
-- local function animate_slider_width(width)
--   sbar.animate("tanh", 30.0, function()
--     volume_slider:set({ slider = { width = width }})
--   end)
-- end

-- volume_slider:subscribe("mouse.clicked", function()
--   local current_width = tonumber(volume_slider:query().slider.width)
--   if current_width > 0 then
--     animate_slider_width(0)
--   else
--     animate_slider_width(100)
--   end
-- end)
