local M = {}

M.config = function()
  require('nvim-lightbulb').setup({
    sign = { enabled = true, priority = 9 },
    autocmd = { enabled = true },
  })
end

return M
