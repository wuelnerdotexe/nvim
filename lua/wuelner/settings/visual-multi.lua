local setup = function()
  local set_var = vim.api.nvim_set_var

  set_var("VM_show_warnings", 0)
  set_var("VM_mouse_mappings", 1)
  set_var("VM_maps", { Undo = "u", Redo = "<C-r>" })
end

return setup
