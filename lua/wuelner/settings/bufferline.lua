local M = {}

M.config = function()
  require('bufferline').setup({
    options = {
      buffer_close_icon = '',
      indicator = { icon = '▊', style = 'icon' },
      offsets = {
        {
          filetype = 'aerial',
          text = 'DOCUMENT SYMBOLS',
          highlight = 'Title',
          separator = false
        },
        {
          filetype = 'fern',
          text = 'FILE TREE',
          highlight = 'Title',
          separator = false
        },
      },
      separator_style = 'thick'
    }
  })

  local keymap_set = vim.keymap.set

  keymap_set('n', 'mB', '<Cmd>BufferLineMovePrev<CR>', { silent = true })
  keymap_set('n', 'gB', '<Cmd>BufferLineCyclePrev<CR>', { silent = true })
  keymap_set('n', '<S-PageUp>', '<Cmd>BufferLineCyclePrev<CR>', {
    silent = true
  })

  keymap_set('i', '<S-PageUp>', '<Cmd>BufferLineCyclePrev<CR>', {
    silent = true
  })

  keymap_set('n', 'mb', '<Cmd>BufferLineMoveNext<CR>', { silent = true })
  keymap_set('n', 'gb', '<Cmd>BufferLineCycleNext<CR>', { silent = true })
  keymap_set('n', '<S-PageDown>', '<Cmd>BufferLineCycleNext<CR>', {
    silent = true
  })

  keymap_set('i', '<S-PageDown>', '<Cmd>BufferLineCycleNext<CR>', {
    silent = true
  })
end

return M

