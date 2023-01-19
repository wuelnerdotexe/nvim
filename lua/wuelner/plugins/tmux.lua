return {
  "aserowy/tmux.nvim",
  keys = { "<C-h>", "<C-j>", "<C-k>", "<C-l>", "<A-h>", "<A-j>", "<A-k>", "<A-l>" },
  config = function()
    require("tmux").setup({
      copy_sync = { enable = false },
      navigation = { cycle_navigation = true, enable_default_keybindings = true },
      resize = { enable_default_keybindings = true, resize_step_x = 1, resize_step_y = 1 },
    })
  end,
}
