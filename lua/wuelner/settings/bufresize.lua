local M = {}

M.config = function()
  require('bufresize').setup({
    register = {
      keys = {
        { 'n', '<A-h>', '<A-h>', { noremap = true, silent = true } },
        { 'n', '<A-j>', '<A-j>', { noremap = true, silent = true } },
        { 'n', '<A-k>', '<A-k>', { noremap = true, silent = true } },
        { 'n', '<A-l>', '<A-l>', { noremap = true, silent = true } },
        { '', '<LeftRelease>', '<LeftRelease>', {
          noremap = true, silent = true
        } },
        { 'i', '<LeftRelease>', '<LeftRelease><C-o>', {
          noremap = true, silent = true
        } }
      },
      trigger_events = { 'BufWinEnter', 'WinEnter' },
    },
    resize = {
      keys = {},
      trigger_events = { 'VimResized' },
      increment = false,
    },
  })
end

return M

