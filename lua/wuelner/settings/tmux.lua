local M = {}

M.config = function()
  require('tmux').setup({
    copy_sync = { enable = false },
    resize = {
      enable_default_keybindings = true, resize_step_x = 3, resize_step_y = 3
    }
  })
end

return M

