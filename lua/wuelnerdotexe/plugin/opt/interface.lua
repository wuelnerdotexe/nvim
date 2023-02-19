return {
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    config = function()
      require("dressing").setup({
        input = {
          insert_only = false,
          border = require("wuelnerdotexe.plugin.configs").border.style,
          win_options = { wrap = true },
          override = function(conf)
            conf.col = -1
            conf.row = 0

            return conf
          end,
        },
        select = {
          backend = { "nui", "builtin" },
          nui = {
            win_options = {
              winblend = require("wuelnerdotexe.plugin.configs").blend,
              cursorline = true,
              winhighlight = "CursorLine:PmenuSel",
            },
            border = { style = require("wuelnerdotexe.plugin.configs").border.style },
          },
          builtin = {
            border = require("wuelnerdotexe.plugin.configs").border.style,
            win_options = {
              winblend = require("wuelnerdotexe.plugin.configs").blend,
              cursorline = true,
              winhighlight = "CursorLine:PmenuSel",
            },
          },
        },
      })
    end,
  },
  {
    "folke/noice.nvim",
    enabled = vim.version().minor >= 9,
    cond = vim.api.nvim_call_function("exists", { "g:neovide" }) ~= 1,
    event = "UIEnter",
    dependencies = "MunifTanjim/nui.nvim",
    config = function()
      vim.api.nvim_set_option_value("cmdheight", 0, require("wuelnerdotexe.plugin.utils").empty_table)
      vim.api.nvim_set_option_value("showcmd", false, require("wuelnerdotexe.plugin.utils").empty_table)
      vim.api.nvim_set_option_value("showmode", false, require("wuelnerdotexe.plugin.utils").empty_table)
      vim.api.nvim_set_option_value(
        "shortmess",
        vim.api.nvim_get_option_value("shortmess", require("wuelnerdotexe.plugin.utils").empty_table) .. "Wc",
        require("wuelnerdotexe.plugin.utils").empty_table
      )

      local border_style = { border = { style = require("wuelnerdotexe.plugin.configs").border.style } }

      require("noice").setup({
        cmdline = { view = "cmdline" },
        popupmenu = { enabled = false },
        lsp = {
          progress = { enabled = false },
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        presets = { bottom_search = true, long_message_to_split = true, lsp_doc_border = true },
        throttle = 42,
        views = {
          split = {
            enter = true,
            size = "25%",
            win_options = { signcolumn = "no", number = false, relativenumber = false, list = false, wrap = false },
          },
          popup = border_style,
          hover = border_style,
          cmdline_popup = border_style,
          confirm = border_style,
        },
      })

      local keymap_callback_scroll_forward = {
        callback = function()
          if not require("noice.lsp").scroll(1) then return "<C-f>" end
        end,
        expr = true,
        replace_keycodes = true,
      }

      vim.api.nvim_set_keymap("n", "<C-f>", "", keymap_callback_scroll_forward)
      vim.api.nvim_set_keymap("i", "<C-f>", "", keymap_callback_scroll_forward)
      vim.api.nvim_set_keymap("s", "<C-f>", "", keymap_callback_scroll_forward)

      local keymap_callback_scroll_backward = {
        callback = function()
          if not require("noice.lsp").scroll(-1) then return "<C-b>" end
        end,
        expr = true,
        replace_keycodes = true,
      }

      vim.api.nvim_set_keymap("n", "<C-b>", "", keymap_callback_scroll_backward)
      vim.api.nvim_set_keymap("i", "<C-b>", "", keymap_callback_scroll_backward)
      vim.api.nvim_set_keymap("s", "<C-b>", "", keymap_callback_scroll_backward)
    end,
  },
}
