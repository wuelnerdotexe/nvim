local config = function()
  local fancy_opts = { cursor = nil, texthl = nil, linehl = nil }

  require("smoothcursor").setup({
    cursor = nil,
    texthl = nil,
    fancy = { enable = true, head = fancy_opts, tail = fancy_opts },
    speed = 24,
    intervals = 40,
    priority = 11,
    threshold = 1,
    disabled_filetypes = {
      "aerial",
      "dap-repl",
      "dapui_breakpoints",
      "dapui_console",
      "dapui_hover",
      "dapui_scopes",
      "dapui_stacks",
      "dapui_watches",
      "checkhealth",
      "fern",
      "fzf",
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
