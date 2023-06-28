return {
  "petertriho/nvim-scrollbar",
  lazy = true,
  event = "UIEnter",
  config = function()
    require("scrollbar").setup({
      throttle_ms = vim.api.nvim_get_option_value("updatetime", { scope = "global" }),
      handle = { highlight = "PmenuSbar" },
      marks = {
        Error = { highlight = "DiagnosticError" },
        Warn = { highlight = "DiagnosticWarn" },
        Info = { highlight = "DiagnosticInfo" },
        Hint = { highlight = "DiagnosticHint" },
      },
      excluded_buftypes = { "prompt" },
      excluded_filetypes = { "cmp_docs", "cmp_menu", "DressingInput", "DressingSelect", "edgy", "noice" },
      autocmd = {
        render = {
          "UIEnter",
          "BufWinEnter",
          "TabEnter",
          "TermEnter",
          "WinEnter",
          "CmdwinLeave",
          "TextChanged",
          "VimResized",
          "WinScrolled",
        },
      },
    })
  end,
}
