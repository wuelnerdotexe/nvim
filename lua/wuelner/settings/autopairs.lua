local config = function()
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
    enable_check_bracket_line = false,
    check_ts = true,
    map_cr = true,
    fast_wrap = { highlight = "Question", highlight_grey = "Dimmed" },
  })

  require("cmp").event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())
end

return config
