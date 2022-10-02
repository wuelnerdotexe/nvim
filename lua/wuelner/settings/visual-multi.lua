local M = {}

M.setup = function()
  local vim_g = vim.g

  vim_g.VM_show_warnings = 0
  vim_g.VM_mouse_mappings = 1
  vim_g.VM_maps = { Undo = 'u', Redo = '<C-r>' }
end

return M

