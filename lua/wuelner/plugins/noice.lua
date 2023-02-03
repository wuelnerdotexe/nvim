return {
  "folke/noice.nvim",
  enabled = vim.version().minor >= 9,
  cond = vim.api.nvim_call_function("exists", { "g:neovide" }) ~= 1,
  event = "UIEnter",
  dependencies = "MunifTanjim/nui.nvim",
  config = function()
    local set_option_value = vim.api.nvim_set_option_value
    local option_opts = {}

    set_option_value("cmdheight", 0, option_opts)
    set_option_value("showcmd", false, option_opts)
    set_option_value("showmode", false, option_opts)

    local hover_opts = { border = { style = "rounded" }, position = { row = 2 } }

    require("noice").setup({
      cmdline = { view = "cmdline", format = { search_down = { view = "cmdline" }, search_up = { view = "cmdline" } } },
      popupmenu = {
        kind_icons = {
          Class = "",
          Color = "",
          Constant = "",
          Constructor = "",
          Enum = "",
          EnumMember = "",
          Field = "",
          File = "",
          Folder = "",
          Function = "",
          Interface = "",
          Keyword = "",
          Method = "",
          Module = "",
          Property = "",
          Snippet = "",
          Struct = "",
          Text = "",
          Unit = "",
          Value = "",
          Variable = "",
        },
      },
      lsp = {
        progress = { enabled = false, throttle = 40 },
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
        hover = { view = "hover", opts = hover_opts },
        signature = { view = "hover", auto_open = { throttle = 40 }, opts = hover_opts },
      },
      presets = { bottom_search = true, long_message_to_split = true, lsp_doc_border = true },
      throttle = 40,
      views = {
        popupmenu = { win_options = { winhighlight = { Normal = "NormalFloat" } } },
        split = {
          size = "25%",
          win_options = { signcolumn = "no", number = false, relativenumber = false, list = false, wrap = false },
        },
        hover = hover_opts,
      },
    })

    local set_keymap = vim.api.nvim_set_keymap
    local scroll = require("noice.lsp").scroll
    local keymap_callback_scroll_backward = {
      callback = function()
        if not scroll(-1) then
          return "<C-b>"
        end
      end,
      expr = true,
      replace_keycodes = true,
    }

    set_keymap("n", "<C-b>", "", keymap_callback_scroll_backward)
    set_keymap("i", "<C-b>", "", keymap_callback_scroll_backward)
    set_keymap("s", "<C-b>", "", keymap_callback_scroll_backward)

    local keymap_callback_scroll_forward = {
      callback = function()
        if not scroll(1) then
          return "<C-f>"
        end
      end,
      expr = true,
      replace_keycodes = true,
    }

    set_keymap("n", "<C-f>", "", keymap_callback_scroll_forward)
    set_keymap("i", "<C-f>", "", keymap_callback_scroll_forward)
    set_keymap("s", "<C-f>", "", keymap_callback_scroll_forward)
  end,
}
