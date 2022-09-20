if packer_plugins['bufferline.nvim']
  and packer_plugins['bufferline.nvim'].loaded
then
  local keymap_set = vim.keymap.set

  keymap_set('n', 'gB', '<Cmd>BufferLineCyclePrev<CR>', { silent = true })
  keymap_set('n', '<S-PageUp>', '<Cmd>BufferLineCyclePrev<CR>', { silent = true })
  keymap_set('i', '<S-PageUp>', '<Cmd>BufferLineCyclePrev<CR>', { silent = true })
  keymap_set('n', '<leader>gb', '<Cmd>BufferLineMoveNext<CR>', { silent = true })
  keymap_set('n', 'gb', '<Cmd>BufferLineCycleNext<CR>', { silent = true })
  keymap_set('n', '<S-PageDown>', '<Cmd>BufferLineCycleNext<CR>', { silent = true })
  keymap_set('i', '<S-PageDown>', '<Cmd>BufferLineCycleNext<CR>', { silent = true })
end

