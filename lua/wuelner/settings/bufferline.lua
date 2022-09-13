local M = {}

M.config = function()
  require('bufferline').setup({
    options = {
      indicator = { icon = '▊', style = 'icon' },
      offsets = {
        {
          filetype = 'fern',
          text = 'File Explorer',
          highlight = 'BufferLineBufferSelected',
          separator = false
        }
      },
      show_buffer_icons = false,
      show_buffer_default_icon = false
    }
  })
end

return M

