local colors = require("colors")

local flow = sbar.add("item", {
  icon = {
    string = "􀐱", -- timer/clock icon
  },
  label = {
    string = "Loading...",
  },
  position = "right",
  update_freq = 30, -- Default to slower updates
  background = {
    corner_radius = 3,
    height = 20,
  },
})

local function update()
  -- Fetch phase from Flow application
  local phase_cmd = "osascript -e \"tell application \\\"Flow\\\" to getPhase\""
  sbar.exec(phase_cmd, function(phase_output)
    local phase = phase_output:gsub("%s+", "") -- trim whitespace
    
    -- Fetch time from Flow application
    local time_cmd = "osascript -e \"tell application \\\"Flow\\\" to getTime\""
    sbar.exec(time_cmd, function(time_output)
      local time = time_output:gsub("%s+", "") -- trim whitespace
      
      -- Set default icon for work/focus
      local icon = "􀐱" -- timer icon
      
      -- Check the phase and adjust the icon if necessary
      if phase == "Break" then
        icon = "􀌾" -- coffee/break icon
      end
      
      -- Dynamically adjust update frequency based on timer state
      if time and time ~= "" and time ~= "00:00" then
        -- Timer is active, update every second for real-time display
        flow:set({ update_freq = 1 })
      else
        -- Timer is idle/stopped, update less frequently to save resources
        flow:set({ update_freq = 30 })
      end
      
      -- Update the item with the new data
      flow:set({
        icon = icon,
        label = phase .. " • " .. time,
      })
    end)
  end)
end

-- Handle errors gracefully
local function safe_update()
  local check_cmd = "osascript -e \"tell application \\\"System Events\\\" to exists application process \\\"Flow\\\"\""
  sbar.exec(check_cmd, function(exists_output)
    local app_running = exists_output:gsub("%s+", "") == "true"
    
    if app_running then
      update()
    else
      -- App not running, use slow updates
      flow:set({ update_freq = 30 })
      flow:set({
        icon = "􀐱", -- timer icon
        label = "Flow not running",
      })
    end
  end)
end

-- Click event handlers
local function handle_click(env)
  if env.BUTTON == "left" then
    -- Left click: Start a session
    sbar.exec("osascript -e \"tell application \\\"Flow\\\" to start\"", function()
      -- Force update after starting session
      safe_update()
    end)
  elseif env.BUTTON == "right" then
    -- Right click: Stop session
    sbar.exec("osascript -e \"tell application \\\"Flow\\\" to stop\"", function()
      -- Force update after stopping
      safe_update()
    end)
  end
end

flow:subscribe("routine", safe_update)
flow:subscribe("forced", safe_update)
flow:subscribe("mouse.clicked", handle_click)
