local colors = require("colors")

local input_source = sbar.add("item", {
  icon = {
    drawing = false,
  },
  label = {
    string = "EN",
    color = colors.white,
  },
  position = "right",
  update_freq = 1,  -- Check every 5 seconds
})

local function update()
  local cmd = "echo $(defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleSelectedInputSources | grep -E 'KeyboardLayout Name|Input Mode' | tail -1 | grep -q \"U.S.\" && echo EN || echo VI)"
  sbar.exec(cmd, function(output)
    if output then
      local lang = output:gsub("%s+", "")  -- Remove whitespace
      if lang == "EN" then
        input_source:set({
          label = {
            string = "EN",
            color = colors.green,
          },
          drawing = true,
        })
      elseif lang == "VI" then
        input_source:set({
          label = {
            string = "VI",
            color = colors.blue,
          },
          drawing = true,
        })
      else
        input_source:set({
          drawing = false,
        })
      end
    else
      input_source:set({
        drawing = false,
      })
    end
  end)
end

-- Initial update
update()

-- Set up the update function to be called periodically
input_source:subscribe("routine", update)

return input_source
