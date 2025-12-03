local colors = require("colors")

local vpn = sbar.add("item", {
--  icon = {
--    drawing = false,
--  },
  label = {
    string = "VPN",
  },
  position = "right",
  update_freq = 60,  -- Check every 10 seconds
})

local function update()
  local cmd = "scutil --nc list | grep Connected"
  sbar.exec(cmd, function(output)
    if output and output ~= "" and not output:match("^%s*$") then
      -- VPN is connected, show the item
      vpn:set({
        drawing = true,
      })
    else
      -- No VPN connection, hide the item
      vpn:set({
        drawing = false,
      })
    end
  end)
end

-- Initial update
update()

-- Set up the update function to be called periodically
vpn:subscribe("routine", update)

return vpn
