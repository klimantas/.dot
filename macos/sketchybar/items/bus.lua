local colors = require("colors")

local bus = sbar.add("item", "bus", {
  position = "right",
  update_freq = 10,
  background = {
    -- color = colors.color_5,
    corner_radius = 3,
    height = 20,
  },
  padding_right = 0,
})

local function update()
  local cmd = "curl -s 'https://maps.trilliumtransit.com/gtfsmap-realtime/feed/dartmouth-vt-us/arrivals?stopCode=4206789&stopID=4206789' | jq -r '.data[] | select(.route_id == \"76431\") | .formattedTime' | head -n 1"
  sbar.exec(cmd, function(output)
    sbar.set(bus.name, {
      label = "Sachem: " ..output,
    })
  end)
end

bus:subscribe("routine", update)
bus:subscribe("forced", update)
