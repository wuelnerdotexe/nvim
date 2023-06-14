return {
  "folke/noice.nvim",
  dependencies = "MunifTanjim/nui.nvim",
  cond = vim.api.nvim_call_function("exists", { "g:neovide" }) ~= 1,
  deactivate = function() require("noice").disable() end,
  event = "UIEnter",
  init = function()
    require("wuelnerdotexe.plugin.util").set_option(
      "shortmess",
      vim.api.nvim_get_option_value("shortmess", TBL) .. "IWc"
    )

    require("wuelnerdotexe.plugin.util").set_option("showmode", false)
    require("wuelnerdotexe.plugin.util").set_option("cmdheight", 0)
    require("wuelnerdotexe.plugin.util").set_option("showcmd", true)
    require("wuelnerdotexe.plugin.util").set_option("showcmdloc", "statusline")
    require("wuelnerdotexe.plugin.util").set_option("winblend", require("wuelnerdotexe.plugin.config").blend)
    require("wuelnerdotexe.plugin.util").set_option("pumblend", require("wuelnerdotexe.plugin.config").blend)
  end,
  config = function()
    local border = require("wuelnerdotexe.plugin.config").border and "rounded" or "shadow"
    local borderstyle = { style = border }

    require("noice").setup({
      cmdline = { view = "cmdline", format = { cmdline = { icon = ">" } } },
      popupmenu = { enabled = false },
      lsp = {
        progress = { enabled = false },
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        bottom_search = true,
        long_message_to_split = true,
        lsp_doc_border = require("wuelnerdotexe.plugin.config").border,
      },
      throttle = 42,
      views = {
        split = {
          enter = true,
          size = "25%",
          win_options = { signcolumn = "no", number = false, relativenumber = false, list = false, wrap = false },
        },
        popup = { border = borderstyle },
        hover = {
          border = borderstyle,
          position = { row = require("wuelnerdotexe.plugin.config").border and 2 or 1, col = 2 },
        },
        mini = {
          timeout = 3000,
          position = { row = require("wuelnerdotexe.plugin.config").border and -2 or -1 },
          border = borderstyle,
          win_options = { winblend = require("wuelnerdotexe.plugin.config").blend },
        },
        cmdline_popup = { border = borderstyle },
        confirm = {
          border = { style = border, padding = { 0, require("wuelnerdotexe.plugin.config").border and 1 or 0 } },
        },
      },
    })

    vim.api.nvim_set_keymap("", "<C-f>", "", {
      callback = function()
        if not require("noice.lsp").scroll(1) then return "<C-f>" end
      end,
      expr = true,
      replace_keycodes = true,
    })

    vim.api.nvim_set_keymap("s", "<C-f>", "", {
      callback = function()
        if not require("noice.lsp").scroll(1) then return "<C-f>" end
      end,
      expr = true,
      replace_keycodes = true,
    })

    vim.api.nvim_set_keymap("", "<C-b>", "", {
      callback = function()
        if not require("noice.lsp").scroll(-1) then return "<C-b>" end
      end,
      expr = true,
      replace_keycodes = true,
    })

    vim.api.nvim_set_keymap("s", "<C-b>", "", {
      callback = function()
        if not require("noice.lsp").scroll(-1) then return "<C-b>" end
      end,
      expr = true,
      replace_keycodes = true,
    })
  end,
}
