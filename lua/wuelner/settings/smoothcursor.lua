local config = function()
  require("smoothcursor").setup({
    cursor = nil,
    texthl = nil,
    fancy = {
      enable = true,
      head = { cursor = nil, texthl = nil, linehl = nil },
      tail = { cursor = nil, texthl = nil, linehl = nil },
    },
    speed = 24,
    intervals = 40,
    priority = 11,
    threshold = 1,
    disable_float_win = true,
    disabled_filetypes = {
      "aerial",
      "checkhealth",
      "dap-repl",
      "dapui_breakpoints",
      "dapui_console",
      "dapui_hover",
      "dapui_scopes",
      "dapui_stacks",
      "dapui_watches",
      "DressingInput",
      "DressingSelect",
      "fern",
      "lspinfo",
      "mason",
      "nerdterm",
      "noice",
      "notify",
      "null-ls-info",
      "packer",
      "qf",
      "TelescopePrompt",
    },
  })
end

return config
