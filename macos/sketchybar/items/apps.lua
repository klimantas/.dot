local colors = require("colors")
local default = require("default")
local settings = require("settings")
local appicons = require("items.appicons")

-- Persistent invisible item for subscriptions (never removed)
local apps_listener = sbar.add("item", "apps_listener", {
  drawing = "off",
  position = "left",
})

local function get_app_icon(app_name)
  return appicons[app_name] or appicons.default
end

local current_items = {}  -- persists between update_windows calls

local function update_windows(windows)
  if type(windows) ~= "table" then return end

  -- 1. Remove previously tracked items by exact name
  for _, name in ipairs(current_items) do
    sbar.remove(name)
  end
  sbar.remove("apps")
  current_items = {}

  table.sort(windows, function(a, b) return a.id < b.id end)

  local item_names = {}
  local count = math.min(#windows, 8)

  for i = 1, count do
    local win = windows[i]
    local item_name = "apps." .. win.id
    table.insert(item_names, item_name)

    local width = math.min(60, 750 / count)
    sbar.add("item", item_name, {
      position = "left",
      label = {
        string = win.app == "Code" and (win.app .. ": " .. win.title) or win.app,
        max_chars = 18,
        width = width,
      },
      icon = {
        string = get_app_icon(win.app),
        font = "Hack Nerd Font Mono:Regular:18.0",
        color = colors.accent,
      },
      click_script = "yabai -m window --focus " .. win.id,
      background = { drawing = "off" },
    })
  end

  current_items = item_names  -- save for next cleanup

  if #item_names > 0 then
    sbar.add("bracket", "apps", item_names, {
      background = {
        color = 0xff24273a,
        border_color = 0xffffffff,
        border_width = 1,
        corner_radius = 9,
        height = 22,
        drawing = "on",
      },
      padding_left = 10,
      padding_right = 10,
    })
  end
end

local function get_apps(env)
  sbar.exec("sleep 0.1 && yabai -m query --windows --space", update_windows)
end

-- Subscriptions on the persistent listener, not the bracket
apps_listener:subscribe("space_change", get_apps)
apps_listener:subscribe("event_custom_windows_changed", get_apps)

-- Initial population on load
get_apps({})

