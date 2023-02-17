return {
  "matze/vim-move",
  keys = {
    { "<A-Left>", "<Plug>MoveCharLeft" },
    { "<A-Down>", "<Plug>MoveLineDown" },
    { "<A-Up>", "<Plug>MoveLineUp" },
    { "<A-Right>", "<Plug>MoveCharRight" },
    { "<A-Left>", "<Plug>MoveBlockLeft", mode = "v" },
    { "<A-Down>", "<Plug>MoveBlockDown", mode = "v" },
    { "<A-Up>", "<Plug>MoveBlockUp", mode = "v" },
    { "<A-Right>", "<Plug>MoveBlockRight", mode = "v" },
  },
  init = function() vim.api.nvim_set_var("move_map_keys", 0) end,
}
