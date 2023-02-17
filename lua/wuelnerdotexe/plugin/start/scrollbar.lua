return {
  "petertriho/nvim-scrollbar",
  event = "VeryLazy",
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
      excluded_filetypes = {
        "dapui_hover",
        "DressingInput",
        "DressingSelect",
        "noice",
        "TelescopePrompt",
      },
      handlers = { gitsigns = true },
    })
  end,
}
