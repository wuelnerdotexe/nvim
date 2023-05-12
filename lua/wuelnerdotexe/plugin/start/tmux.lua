return {
  "aserowy/tmux.nvim",
  lazy = true,
  keys = { "<C-h>", "<C-j>", "<C-k>", "<C-l>", "<A-h>", "<A-j>", "<A-k>", "<A-l>" },
  init = function()
    require("wuelnerdotexe.plugin.util").set_option("clipboard", "unnamedplus")

    if not os.getenv("TMUX") then return end

    vim.api.nvim_create_autocmd("VimEnter", {
      once = true,
      callback = function() require("lazy").load({ plugins = { "tmux.nvim" } }) end,
    })
  end,
  config = function()
    require("tmux").setup({
      copy_sync = {
        enable = true,
        ignore_buffers = { empty = false },
        redirect_to_clipboard = true,
        register_offset = 0,
        sync_clipboard = false,
        sync_registers = true,
        sync_deletes = true,
        sync_unnamed = true,
      },
      navigation = { cycle_navigation = true, enable_default_keybindings = true, persist_zoom = false },
      resize = { enable_default_keybindings = true, resize_step_x = 1, resize_step_y = 1 },
    })
  end,
}
