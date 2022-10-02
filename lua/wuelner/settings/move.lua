local M = {}

M.setup = function()
  vim.g.move_map_keys = 0
end

M.config = function()
  local keymap_set = vim.keymap.set

  keymap_set('n', '<A-Left>', '<Plug>MoveCharLeft')
  keymap_set('n', '<A-Down>', '<Plug>MoveLineDown')
  keymap_set('n', '<A-Up>', '<Plug>MoveLineUp')
  keymap_set('n', '<A-Right>', '<Plug>MoveCharRight')
  keymap_set('v', '<A-Left>', '<Plug>MoveBlockLeft')
  keymap_set('v', '<A-Down>', '<Plug>MoveBlockDown')
  keymap_set('v', '<A-Up>', '<Plug>MoveBlockUp')
  keymap_set('v', '<A-Right>', '<Plug>MoveBlockRight')
end

return M

