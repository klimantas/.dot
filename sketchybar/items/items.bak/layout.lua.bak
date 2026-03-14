local colors = require("colors")
local layout = sbar.add("item", {
  position = "left",
  -- padding_left = -4,
})

-- local function update()
--  local cmd = "yabai -m query --spaces --space | jq -r '.type'"
--  sbar.exec(cmd, function(output)
--    local icon = "􀟻"
--    output = output:gsub("\n", ""):gsub("%s", "")
--    if output == "bsp" then
--      icon = "􀟻"
--    elseif output == "float" then
--      icon = "􁎄"
--    elseif output == "stack" then
--      icon = "􀏭"
--    else
--      icon = "?"
--    end
--    sbar.set(layout.name, {
--        -- label = output,
--        icon = {
--            string = icon,
--        },
--    })
--
--  end)

-- end
-- layout:subscribe("routine", update)
layout:subscribe("event_custom_layout_changed", update)
-- layout:subscribe("event_custom_windows_changed", update)
layout:subscribe("space_change", update)
layout:subscribe("forced", update)

layout:subscribe("mouse.clicked", function(_)
  local cmd = "yabai -m query --spaces --space | jq -r '.type'"
  sbar.exec(cmd, function(output)
    local output = output:gsub("\n", ""):gsub("%s", "")
      -- sbar.exec("yabai -m space --layout float")
    -- elseif output == "float" then
    --   sbar.exec("yabai -m space --layout stack")
  end)
end)
-- layout:subscribe("mouse.clicked", function(_)
--   local cmd = "yabai -m query --spaces --space | jq -r '.type'"
--   sbar.exec(cmd, function(output)
--     output = output:gsub("\n", ""):gsub("%s", "")
--     if output == "bsp" then
--       sbar.exec("yabai -m space --layout float")
--     elseif output == "float" then
--       sbar.exec("yabai -m space --layout stack")
--     elseif output == "stack" then
--       sbar.exec("yabai -m space --layout bsp")
--   end)
-- )
