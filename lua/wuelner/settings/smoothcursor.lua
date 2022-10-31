local M = {}

M.config = function()
  require("smoothcursor").setup({
    cursor = nil,
    texthl = nil,
    fancy = {
      enable = true,
      head = { cursor = nil, texthl = nil, linehl = nil },
      tail = { cursor = nil, texthl = nil },
    },
    speed = 24,
    intervals = 40,
    priority = 11,
    threshold = 1,
    disabled_filetypes = nil,
  })
end

return M
