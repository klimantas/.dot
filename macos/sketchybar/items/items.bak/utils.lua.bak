
local function logging(msg)
    local log_file = os.getenv("HOME") .. "/Desktop/bar.log"
    local file = io.open(log_file, "a")
    -- write timestamp + msg
    file:write(os.date("%Y-%m-%d %H:%M:%S") .. "-" .. msg .. "\n")
    file:close()
  end
  
local function log_table(t)
    local log_file = os.getenv("HOME") .. "/Desktop/bar.log"
    local file = io.open(log_file, "a")
    -- write timestamp + msg
    -- log every key value
    for k, v in pairs(t) do
        file:write(os.date("%Y-%m-%d %H:%M:%S") .. "-" .. k .. ": " .. tostring(v) .. "\n")
    end
end