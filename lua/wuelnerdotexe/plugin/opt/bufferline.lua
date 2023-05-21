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

      vim.api.nvim_set_keymap("", "<S-End>", "", {
        callback = function() vim.api.nvim_command("BufferLineMoveNext") end,
      })

      vim.api.nvim_set_keymap("", "<S-Home>", "", {
        callback = function() vim.api.nvim_command("BufferLineMovePrev") end,
      })

      vim.api.nvim_set_keymap("n", "gb", "", {
        callback = function() vim.api.nvim_command("BufferLineCycleNext") end,
      })

      vim.api.nvim_set_keymap("", "<S-PageDown>", "", {
        callback = function() vim.api.nvim_command("BufferLineCycleNext") end,
      })

      vim.api.nvim_set_keymap("n", "gB", "", {
        callback = function() vim.api.nvim_command("BufferLineCyclePrev") end,
      })

      vim.api.nvim_set_keymap("", "<S-PageUp>", "", {
        callback = function() vim.api.nvim_command("BufferLineCyclePrev") end,
      })
    end,
  },
}
