return {
  "folke/noice.nvim",
  dependencies = "MunifTanjim/nui.nvim",
  cond = vim.api.nvim_call_function("exists", { "g:neovide" }) ~= 1,
  deactivate = function() require("noice").disable() end,
  event = "UIEnter",
  init = function()
    require("wuelnerdotexe.plugin.util").add_colorscheme_integration("noice")

    vim.opt.shortmess:prepend("I")

    require("wuelnerdotexe.plugin.util").set_option("showmode", false)
    require("wuelnerdotexe.plugin.util").set_option("cmdheight", 0)
    require("wuelnerdotexe.plugin.util").set_option("showcmd", true)
    require("wuelnerdotexe.plugin.util").set_option("showcmdloc", "statusline")

    table.insert(require("wuelnerdotexe.plugin.util").user_interface_filetypes, "noice")
  end,
  config = function()
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
      presets = { bottom_search = true, long_message_to_split = true },
      throttle = 42,
      views = {
        split = {
          enter = true,
          size = "25%",
          win_options = { signcolumn = "no", number = false, relativenumber = false, list = false, wrap = false },
        },
        popup = { border = { style = "rounded" } },
        hover = { border = { style = "rounded" }, position = { row = 2, col = 2 } },
        mini = {
          timeout = 3000,
          position = { row = -2 },
          border = { style = "rounded" },
          win_options = { winblend = vim.api.nvim_get_option_value("winblend", { scope = "global" }) },
        },
        cmdline_popup = { border = { style = "rounded" } },
        confirm = { border = { style = "rounded", padding = { 0, 1 } } },
      },
    })

    vim.opt.shortmess:append("cC")
    vim.opt.shortmess:remove("sS")

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
