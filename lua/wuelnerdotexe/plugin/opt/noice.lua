return {
  "folke/noice.nvim",
  enabled = not require("wuelnerdotexe.plugin.config").minimal_setup,
  cond = vim.api.nvim_call_function("exists", { "g:neovide" }) ~= 1,
  event = "UIEnter",
  dependencies = "MunifTanjim/nui.nvim",
  deactivate = function() require("noice").disable() end,
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
    local border = require("wuelnerdotexe.plugin.util").get_border()
    local borderstyle = { border = { style = border.style } }

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
      presets = { bottom_search = true, long_message_to_split = true, lsp_doc_border = border.enabled },
      throttle = 42,
      views = {
        split = {
          enter = true,
          size = "25%",
          win_options = { signcolumn = "no", number = false, relativenumber = false, list = false, wrap = false },
        },
        popup = borderstyle,
        hover = { border = { style = border.style }, position = { row = 2, col = 2 } },
        mini = {
          timeout = 3000,
          position = { row = border.enabled and -2 or -1 },
          border = { style = border.style },
          win_options = { winblend = require("wuelnerdotexe.plugin.config").blend },
        },
        cmdline_popup = borderstyle,
        confirm = borderstyle,
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
}
