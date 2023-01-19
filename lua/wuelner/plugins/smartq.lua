return {
  "marklcrns/vim-smartq",
  keys = {
    { "q", "<Plug>(smartq_this)" },
    { "<C-w>o", "<Plug>(smartq_close_splits)", mode = { "n", "v" } },
  },
  init = function()
    local set_var = vim.api.nvim_set_var

    set_var("smartq_default_mappings", 0)
    set_var("smartq_no_exit", 1)
    set_var("smartq_auto_close_splits", 1)
    set_var("smartq_goyo_integration", 0)
    set_var("smartq_zenmode_integration", 0)

    local filetypes = {
      "aerial",
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
      "notify",
      "null-ls-info",
      "qf",
      "TelescopePrompt",
    }

    set_var("smartq_exclude_filetypes", filetypes)
    set_var("smartq_q_filetypes", filetypes)
    set_var("smartq_bd_filetypes", filetypes)

    local buftypes = { "loclist", "nofile", "prompt", "quickfix" }

    set_var("smartq_exclude_buftypes", buftypes)
    set_var("smartq_q_buftypes", buftypes)
    set_var("smartq_bw_buftypes", buftypes)
  end,
}
