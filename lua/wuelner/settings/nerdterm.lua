local config = function()
  vim.api.nvim_set_keymap("n", "<leader>tt", "<Plug>(NERDTermToggle)", {})
end

return config
