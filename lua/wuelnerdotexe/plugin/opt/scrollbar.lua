return {
  "petertriho/nvim-scrollbar",
  lazy = true,
  event = "UIEnter",
  opts = function(_, opts)
    opts.throttle_ms = vim.api.nvim_get_option_value("updatetime", { scope = "global" })

    opts.handle = { highlight = "PmenuSbar" }

    opts.marks = {
      Error = { highlight = "DiagnosticError" },
      Warn = { highlight = "DiagnosticWarn" },
      Info = { highlight = "DiagnosticInfo" },
      Hint = { highlight = "DiagnosticHint" },
    }

    opts.excluded_buftypes = { "prompt" }

    opts.autocmd = {
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
    }
  end,
  config = function(_, opts) require("scrollbar").setup(opts) end,
}
