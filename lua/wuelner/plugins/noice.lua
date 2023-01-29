return {
  "folke/noice.nvim",
  enabled = vim.version().minor >= 9,
  cond = vim.api.nvim_call_function("exists", { "g:neovide" }) ~= 1,
  event = "UIEnter",
  dependencies = {
    "MunifTanjim/nui.nvim",
    {
      "rcarriga/nvim-notify",
      config = function()
        vim.api.nvim_set_option_value("termguicolors", true, {})

        require("notify").setup({ background_colour = "NormalFloat", fps = 24, render = "minimal", timeout = 600 })
      end,
    },
  },
  config = function()
    local set_option_value = vim.api.nvim_set_option_value
    local option_opts = {}

    set_option_value("cmdheight", 0, option_opts)
    set_option_value("showcmd", false, option_opts)
    set_option_value("showmode", false, option_opts)

    local hover_opts = { border = { style = "rounded" }, position = { row = 2 } }

    require("noice").setup({
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
      presets = { command_palette = true, long_message_to_split = true, lsp_doc_border = true },
      throttle = 40,
      views = {
        popupmenu = { win_options = { winhighlight = { Normal = "NormalFloat" } } },
        split = {
          size = "25%",
          win_options = { signcolumn = "no", number = false, relativenumber = false, list = false, wrap = false },
        },
        cmdline_popup = { win_options = { wrap = true, linebreak = true } },
        hover = hover_opts,
      },
    })

    local set_keymap = vim.api.nvim_set_keymap
    local scroll = require("noice.lsp").scroll

    set_keymap("n", "<C-b>", "", {
      callback = function()
        if not scroll(-1) then
          return "<c-b>"
        end
      end,
      expr = true,
      replace_keycodes = true,
    })

    set_keymap("n", "<C-f>", "", {
      callback = function()
        if not scroll(1) then
          return "<c-f>"
        end
      end,
      expr = true,
      replace_keycodes = true,
    })
  end,
}
