if packer_plugins['bufferline.nvim'].loaded then
  local keymap = vim.keymap
  local opts = { silent = true }

  keymap.set('n', 'gB', '<Cmd>BufferLineCyclePrev<CR>', opts)
  keymap.set('n', 'gb', '<Cmd>BufferLineCycleNext<CR>', opts)
end

