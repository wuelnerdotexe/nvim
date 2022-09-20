local M = {}

M.config = function()
  require('bufresize').setup({
    register = {
      keys = {
        { 'n', '<Plug>(ResizerLeft)', '<Cmd>ResizerLeft<CR>', {
          noremap = true, silent = true
        } },
        { 'n', '<Plug>(ResizerDown)', '<Cmd>ResizerDown<CR>', {
          noremap = true, silent = true
        } },
        { 'n', '<Plug>(ResizerUp)', '<Cmd>ResizerUp<CR>', {
          noremap = true, silent = true
        } },
        { 'n', '<Plug>(ResizerRight)', '<Cmd>ResizerRight<CR>', {
          noremap = true, silent = true
        } },
        { '', '<LeftRelease>', '<LeftRelease>', {
          noremap = true, silent = true
        } },
      },
      trigger_events = { 'BufWinEnter', 'WinEnter' },
    },
    resize = {
      keys = {},
      trigger_events = { 'VimResized' },
      increment = 3,
    },
  })
end

return M

