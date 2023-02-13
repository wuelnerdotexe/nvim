return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  config = function()
    require("nvim-autopairs").setup({
      disable_filetype = {
        "aerial",
        "checkhealth",
        "dapui_breakpoints",
        "dapui_console",
        "dapui_scopes",
        "dapui_stacks",
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
      enable_check_bracket_line = false,
      check_ts = true,
      map_cr = false,
      fast_wrap = { highlight = "Question", highlight_grey = "Dimmed" },
    })
  end,
}
