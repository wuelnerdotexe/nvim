local M = {}

M.setup = function()
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
    "lspinfo",
    "mason",
    "nerdterm",
    "noice",
    "notify",
    "null-ls-info",
    "packer",
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
end

M.config = function()
  local set_keymap = vim.api.nvim_set_keymap
  local keymap_opts = {}

  set_keymap("n", "q", "<Plug>(smartq_this)", keymap_opts)
  set_keymap("n", "<C-w>o", "<Plug>(smartq_close_splits)", keymap_opts)
  set_keymap("v", "<C-w>o", "<Plug>(smartq_close_splits)", keymap_opts)
end

return M
