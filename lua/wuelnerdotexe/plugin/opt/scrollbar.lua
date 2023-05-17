return {
  "petertriho/nvim-scrollbar",
  enabled = not require("wuelnerdotexe.plugin.config").minimal_setup,
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
      excluded_filetypes = { "DressingInput", "TelescopePrompt" },
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
