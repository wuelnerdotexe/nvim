return {
  "petertriho/nvim-scrollbar",
  event = require("wuelnerdotexe.plugin.config").open_file_event,
  dependencies = "lewis6991/gitsigns.nvim",
  config = function()
    vim.api.nvim_set_option_value("shortmess", vim.api.nvim_get_option_value("shortmess", TBL) .. "I", TBL)

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
