local set_option_value = vim.api.nvim_set_option_value

set_option_value("signcolumn", "yes:1", { buf = 0 })
set_option_value("cursorline", true, { buf = 0 })
