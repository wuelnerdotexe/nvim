local M = {}

M.config = function()
  vim.keymap.set("n", "<leader>tt", "<Plug>(NERDTermToggle)<CR>")
end

return M
