local setup = function()
  vim.g.VM_show_warnings = 0
  vim.g.VM_mouse_mappings = 1
  vim.g.VM_maps = { Undo = "u", Redo = "<C-r>" }
end

return setup
