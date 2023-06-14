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
    { "<Bslash><Bslash><Bslash>", mode = { "n", "x" } },
  },
  cmd = { "VMClear", "VMDebug", "VMFromSearch", "VMLive", "VMRegisters", "VMSearch", "VMTheme" },
  init = function()
    vim.api.nvim_set_var("VM_show_warnings", 0)
    vim.api.nvim_set_var("VM_mouse_mappings", 1)
    vim.api.nvim_set_var("VM_maps", { Undo = "u", Redo = "<C-r>" })
  end,
}
