return {
  "mg979/vim-visual-multi",
  keys = {
    "<S-Left>",
    "<C-Down>",
    "<C-Up>",
    "<S-Right>",
    "<C-LeftMouse>",
    "<C-RightMouse>",
    "<M-C-RightMouse>",
    { "<C-n>", mode = { "n", "x" } },
    { "<Bslash><Bslash>", mode = { "n", "x" } },
  },
  init = function()
    local set_var = vim.api.nvim_set_var

    set_var("VM_show_warnings", 0)
    set_var("VM_mouse_mappings", 1)
    set_var("VM_maps", { Undo = "u", Redo = "<C-r>" })
  end,
}
