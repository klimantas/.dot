local colors = require("colors")
local default = require("default")
local settings = require("settings")
-- local appicons = require("../items/appicons")

local upnext = sbar.add("bracket", "upnext", {}, {
  position = "right",
  update_freq = 10 * 60,
})

local function update_events(events_string)
  -- events_string: multiple lines, each line is eventname % time seperated by %

  sbar.remove("/upnext.\\.*/")

  local events = {}
  for line in events_string:gmatch("[^\r\n]+") do
    local event = {}
    
    -- get name and time separated by %
    local name, time = line:match("([^%%]+)%%([^%%]+)")

    -- if time is today, omit time for mat like May 13, 2025
    local today = os.date("%B %d, %Y")
    -- find the word " at" and get everything before it
    local date = time:match("^(.-) at")
    local time = time:match(" at (.+)")

    if date == today then
      date = ""
    else
      date = "Tmr "
    end
    

    event['name'] = name
    event['time'] = date .. time
    table.insert(events, event)
  end

  -- reverse events array

 
  -- for event_name, event in ipairs(events) do
  -- reverse order
  for i = #events, 1, -1 do
    local event = events[i]
    -- local event
    sbar.add("item", "upnext." .. event['name'], {
      position = "right",
      scroll_texts = "on",
      padding_left = 14,
      icon = {
        string = event['time'] ,
        color = colors.accent,
      },
      label = {
        string = "-" .. event['name'],
        max_chars = 20,
        -- scroll_duration = 150,
        -- width = 100,
      },
    })
  end

end

local function get_calendar(env)
  sbar.exec("icalBuddy -eed -n -nc -nrd -ea -iep datetime,title -b '' -ps '|%|' eventsToday+2", update_events)
end

-- apps:subscribe("space_change", get_apps)
-- apps:subscribe("event_custom_windows_changed", get_apps)
-- apps:subscribe("front_app_switched", get_apps)
-- apps:subscribe("front_app_switched", focus_window)
upnext:subscribe("routine", get_calendar)
upnext:subscribe("forced", get_calendar)
