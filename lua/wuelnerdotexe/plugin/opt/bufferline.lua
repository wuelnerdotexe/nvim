return {
  {
    "akinsho/bufferline.nvim",
    enabled = not require("wuelnerdotexe.plugin.config").minimal_setup,
    event = "UIEnter",
    dependencies = "nvim-tree/nvim-web-devicons",
    init = function()
      require("wuelnerdotexe.plugin.util").set_option("termguicolors", true)
      require("wuelnerdotexe.plugin.util").set_option("showtabline", 2)
    end,
    config = function()
      require("bufferline").setup({
        options = {
          max_name_length = 16,
          max_prefix_length = 16,
          tab_size = 20,
          indicator = { icon = "▎", style = "icon" },
          offsets = {
            { filetype = "aerial", text = "OUTLINE", highlight = "Title", separator = false },
            { filetype = "neo-tree", text = "EXPLORER", highlight = "Title", separator = false },
          },
          show_close_icon = false,
          separator_style = { "▎", "▎" },
        },
      })

      vim.api.nvim_set_keymap("n", "<S-End>", "", {
        callback = function() vim.api.nvim_command("BufferLineMoveNext") end,
      })

      vim.api.nvim_set_keymap("n", "<S-Home>", "", {
        callback = function() vim.api.nvim_command("BufferLineMovePrev") end,
      })
    end,
  },
  {
    "roobert/bufferline-cycle-windowless.nvim",
    enabled = not require("wuelnerdotexe.plugin.config").minimal_setup,
    dependencies = "akinsho/bufferline.nvim",
    keys = {
      { "gb", function() vim.api.nvim_command("BufferLineCycleWindowlessNext") end },
      { "<S-PageDown>", function() vim.api.nvim_command("BufferLineCycleWindowlessNext") end, mode = { "n", "i" } },
      { "gB", function() vim.api.nvim_command("BufferLineCycleWindowlessPrev") end },
      { "<S-PageUp>", function() vim.api.nvim_command("BufferLineCycleWindowlessPrev") end, mode = { "n", "i" } },
    },
    config = function() require("bufferline-cycle-windowless").setup({ default_enabled = true }) end,
  },
}
