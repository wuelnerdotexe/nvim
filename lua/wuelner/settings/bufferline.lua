local M = {}

M.config = function()
  require('bufferline').setup({
    options = {
      buffer_close_icon = '',
      indicator = { icon = '▊', style = 'icon' },
      offsets = {
        {
          filetype = 'fern',
          text = 'FILE EXPLORER',
          highlight = 'Title',
          separator = false
        }
      },
      separator_style = 'thick'
    }
  })

  local keymap_set = vim.keymap.set

  keymap_set('n', 'mB', '<Cmd>BufferLineMovePrev<CR>', { silent = true })
  keymap_set('n', 'mb', '<Cmd>BufferLineMoveNext<CR>', { silent = true })
end

return M

