require("tmux").setup({
  copy_sync = { enable = false },
  navigation = { cycle_navigation = true, enable_default_keybindings = true },
  resize = { enable_default_keybindings = true, resize_step_x = 1, resize_step_y = 1 },
})
