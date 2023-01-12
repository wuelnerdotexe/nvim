local timing_linear = require("mini.animate").gen_timing.linear({ duration = 40, unit = "total" })
local config_timing = { timing = timing_linear }

require("mini.animate").setup({
  cursor = config_timing,
  scroll = config_timing,
  resize = config_timing,
  open = config_timing,
  close = config_timing,
})
