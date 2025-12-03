local uname = sbar.add("item", {
  position = "right",
  icon = { drawing = false },
  label = "" .. os.getenv("USER") .. "",
  padding_left = 5,
  padding_right = 5,
})
