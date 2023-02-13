return {
  {
    "akinsho/bufferline.nvim",
    event = "UIEnter",
    config = function()
      vim.api.nvim_set_option_value("termguicolors", true, {})

      require("bufferline").setup({
        options = {
          max_name_length = 14,
          max_prefix_length = 14,
          tab_size = 18,
          indicator = { icon = "▎", style = "icon" },
          offsets = {
            { filetype = "aerial", text = "OUTLINE EXPLORER", highlight = "Title", separator = false },
            { filetype = "fern", text = "FOLDERS EXPLORER", highlight = "Title", separator = false },
          },
          show_buffer_icons = false,
          show_buffer_default_icon = false,
          show_close_icon = false,
          separator_style = { "▎", "▎" },
        },
      })

      vim.api.nvim_set_keymap("n", "<S-End>", "", {
        callback = function()
          vim.api.nvim_command("BufferLineMoveNext")
        end,
      })

      vim.api.nvim_set_keymap("n", "<S-Home>", "", {
        callback = function()
          vim.api.nvim_command("BufferLineMovePrev")
        end,
      })
    end,
  },
  {
    "roobert/bufferline-cycle-windowless.nvim",
    dependencies = "akinsho/bufferline.nvim",
    keys = {
      {
        "gb",
        function()
          vim.api.nvim_command("BufferLineCycleWindowlessNext")
        end,
      },
      {
        "<S-PageDown>",
        function()
          vim.api.nvim_command("BufferLineCycleWindowlessNext")
        end,
      },
      {
        "gB",
        function()
          vim.api.nvim_command("BufferLineCycleWindowlessPrev")
        end,
      },
      {
        "<S-PageUp>",
        function()
          vim.api.nvim_command("BufferLineCycleWindowlessPrev")
        end,
        mode = { "n", "i" },
      },
    },
    config = function()
      require("bufferline-cycle-windowless").setup({ default_enabled = true })
    end,
  },
}
