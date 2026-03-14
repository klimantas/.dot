local colors = require("colors")
local default = require("default")
local settings = require("settings")
local appicons = require("../items/appicons")

local apps = sbar.add("bracket", "apps", {}, {
  position = "left",
})

local function get_app_icon(app_name)
  return appicons[app_name] or appicons.default
end

local function focus_window(env)
  sbar.exec("yabai -m query --windows id,has-focus", function(output)
    for _, line in ipairs(output) do
      if line['has-focus'] then
        sbar.set("apps." .. line.id, {
          background = { color = colors.accent },
          label = { color = colors.background },
          icon = { color = colors.background }
        })
      else
        sbar.set("apps." .. line.id, {
          background = { color = colors.background },
          label = { color = colors.accent },
          icon = { color = colors.accent }
        })
      end
    end
  end)
end

local function update_windows(windows)
  -- need to check if exists
  sbar.remove("/apps.\\.*/")
  -- short windows by increasing id
  table.sort(windows, function(a, b) return a.id < b.id end)

  for _, line in ipairs(windows) do
    width = math.min(60, 750 / #windows)
    sbar.add("item", "apps." .. line['id'], {
      -- scroll_texts="on",
      label = {
        string = line['app'] == "Code" and (line['app'] .. ": " .. line['title']) or line['app'],
        max_chars = 18,
        width = width,
        -- scroll_duration = 70,
        -- highlight_color = colors.accent,
        -- highlight = line['has-focus'],
        padding_right = 0, 
      },
      icon = {
        -- string = get_app_icon(line['app']),
        string = get_app_icon(line['app']),
        font = "Hack Nerd Font Mono:Regular:18.0",
        -- use nerd font
        padding_left = 4,
        padding_right = 0,
        color = colors.accent,
      },
      padding_right = 10,
      -- padding_top = -10,
      click_script = "yabai -m window --focus " .. line['id'],
      background = {
        -- color = colors.bg2,
        height = 16,
        corner_radius = 3,
        -- border_width = 4,
        border_color = colors.accent,
        -- padding_left = -10,
      },
    })
  end
end

-- local function mouse_click(env)
--   if env.BUTTON == "right" then
--     sbar.exec("yabai -m window --destroy " .. env.SID)
--   else
--     sbar.exec("yabai -m space --focus " .. env.SID)
--   end
-- end



local function get_apps(env)
  sbar.exec("yabai -m query --windows id,title,app,has-focus --space", update_windows)
end

apps:subscribe("space_change", get_apps)
apps:subscribe("event_custom_windows_changed", get_apps)
-- apps:subscribe("front_app_switched", get_apps)
-- apps:subscribe("front_app_switched", focus_window)
-- apps:subscribe("event_custom_windows_focused", focus_window)
-- apps:subscribe("front_app_switched", get_apps)
-- window_focused

