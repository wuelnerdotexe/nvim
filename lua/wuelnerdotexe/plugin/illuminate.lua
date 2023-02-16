return {
  "RRethy/vim-illuminate",
  event = { "BufNewFile", "BufRead", "BufAdd" },
  config = function()
    require("illuminate").configure({
      delay = 42,
      filetypes_denylist = {
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
        "lazy",
        "lspinfo",
        "mason",
        "nerdterm",
        "noice",
        "null-ls-info",
        "qf",
        "TelescopePrompt",
      },
      max_file_lines = 400,
    })
  end,
}
