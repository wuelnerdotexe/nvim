local set_option_value = vim.api.nvim_set_option_value
local option_opts = { buf = 0 }

set_option_value("signcolumn", "no", option_opts)
set_option_value("number", false, option_opts)
set_option_value("relativenumber", false, option_opts)
set_option_value("list", false, option_opts)
