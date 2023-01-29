local command = vim.api.nvim_command

return {
  "akinsho/bufferline.nvim",
  event = "UIEnter",
  dependencies = {
    "roobert/bufferline-cycle-windowless.nvim",
    keys = {
      {
        "gB",
        function()
          command("BufferLineCycleWindowlessPrev")
        end,
      },
      {
        "<S-PageUp>",
        function()
          command("BufferLineCycleWindowlessPrev")
        end,
        mode = { "n", "i" },
      },
      {
        "gb",
        function()
          command("BufferLineCycleWindowlessNext")
        end,
      },
      {
        "<S-PageDown>",
        function()
          command("BufferLineCycleWindowlessNext")
        end,
      },
    },
    config = function()
      require("bufferline-cycle-windowless").setup({ default_enabled = true })
    end,
  },
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

    local set_keymap = vim.api.nvim_set_keymap

    set_keymap("n", "<S-Home>", "", {
      callback = function()
        command("BufferLineMovePrev")
      end,
    })

    set_keymap("n", "<S-End>", "", {
      callback = function()
        command("BufferLineMoveNext")
      end,
    })
  end,
}
