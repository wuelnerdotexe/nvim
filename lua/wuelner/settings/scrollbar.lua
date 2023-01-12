vim.api.nvim_set_option_value("shortmess", vim.api.nvim_get_option_value("shortmess", {}) .. "I", {})

require("scrollbar").setup({
  show_in_active_only = true,
  throttle_ms = 40,
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
    -- "noice",
    -- "notify",
    "TelescopePrompt",
  },
  handlers = { gitsigns = true },
})
