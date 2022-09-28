local M = {}

M.config = function()
  require('bufresize').setup({
    register = {
      keys = {
        { 'n', '<A-Left>', '<Plug>(ResizerLeft)', {
          noremap = true, silent = true
        } },
        { 'n', '<A-Down>', '<Plug>(ResizerDown)', {
          noremap = true, silent = true
        } },
        { 'n', '<A-Up>', '<Plug>(ResizerUp)', {
          noremap = true, silent = true
        } },
        { 'n', '<A-Right>', '<Plug>(ResizerRight)', {
          noremap = true, silent = true
        } },
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
      increment = 3,
    },
  })
end

return M

