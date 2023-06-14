return {
  "petertriho/nvim-scrollbar",
  lazy = true,
  event = "UIEnter",
  config = function()
    require("scrollbar").setup({
      throttle_ms = 42,
      handle = { highlight = "PmenuSbar" },
      marks = {
        Error = { highlight = "DiagnosticError" },
        Warn = { highlight = "DiagnosticWarn" },
        Info = { highlight = "DiagnosticInfo" },
        Hint = { highlight = "DiagnosticHint" },
      },
      excluded_buftypes = { "prompt" },
      excluded_filetypes = { "cmp_docs", "cmp_menu", "DressingInput", "noice", "TelescopePrompt" },
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
