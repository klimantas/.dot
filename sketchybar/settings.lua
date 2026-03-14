local colors = require("colors")

sbar.bar({
  -- height = 25,
  position = "top",
  padding_right = 400, -- notification gap
  color = 0x00000000,  
  padding_left = 10,
  -- margin = 10,
  -- corner_radius = 9,
  sticky = "on",
  -- If you want the bar to physically end early:
  -- width = "dynamic", 
})

return {
  -- paddings = 3,
  font = "Hack Nerd Font",
  text_font = "SF Pro",
}
