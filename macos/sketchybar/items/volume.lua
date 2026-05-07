local colors = require("colors")
local icons = require("icons")

local volume = sbar.add("slider", "volume", 100, {
  position = "right",
  padding_left = 0,
  padding_right = 0,
  updates = true,
  icon = {
    padding_right = 6,
  },
  background = {
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
    knob = {
       drawing = true,
    },
  },
})

-- Update system volume on slider interaction
volume:subscribe("mouse.clicked", function(env)
  sbar.exec("osascript -e 'set volume output volume " .. env.percentage .. "'")
end)

-- Update slider and icon on system volume change
volume:subscribe("volume_change", function(env)
  local volume_level = tonumber(env.INFO)
  if not volume_level then return end 

  -- Native check for audio device to swap icons
  sbar.exec("system_profiler SPAudioDataType | grep -A 10 'Default Output Device: Yes' | grep 'Manufacturer'", function(output)
    local icon = icons.volume._100 
    
    if string.find(output, "Apple") then
      icon = icons.volume._66
    else
      icon = icons.headphone
    end
    
    volume:set({
      icon = { string = icon },
      slider = { percentage = volume_level }
    })
  end)
end)
