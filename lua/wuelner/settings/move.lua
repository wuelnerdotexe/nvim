local M = {}

M.setup = function()
  vim.api.nvim_set_var("move_map_keys", 0)
end

M.config = function()
  local set_keymap = vim.api.nvim_set_keymap
  local keymap_opts = {}

  set_keymap("n", "<A-Left>", "<Plug>MoveCharLeft", keymap_opts)
  set_keymap("n", "<A-Down>", "<Plug>MoveLineDown", keymap_opts)
  set_keymap("n", "<A-Up>", "<Plug>MoveLineUp", keymap_opts)
  set_keymap("n", "<A-Right>", "<Plug>MoveCharRight", keymap_opts)
  set_keymap("v", "<A-Left>", "<Plug>MoveBlockLeft", keymap_opts)
  set_keymap("v", "<A-Down>", "<Plug>MoveBlockDown", keymap_opts)
  set_keymap("v", "<A-Up>", "<Plug>MoveBlockUp", keymap_opts)
  set_keymap("v", "<A-Right>", "<Plug>MoveBlockRight", keymap_opts)
end

return M
