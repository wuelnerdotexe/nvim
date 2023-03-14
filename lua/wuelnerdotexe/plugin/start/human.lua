return {
  "wuelnerdotexe/human.vim",
  lazy = false,
  init = function()
    vim.api.nvim_set_var("bufonly_exclude_buftypes", { "terminal" })
    vim.api.nvim_set_var("bufonly_exclude_filetypes", {
      "aerial",
      "dap-repl",
      "dapui_breakpoints",
      "dapui_console",
      "dapui_scopes",
      "dapui_stacks",
      "dapui_watches",
      "DressingInput",
      "DressingSelect",
      "neo-tree",
    })
  end,
  config = function()
    vim.api.nvim_set_option_value("laststatus", 2, TBL)
    vim.api.nvim_set_option_value("showtabline", 1, TBL)
    vim.api.nvim_set_option_value("spell", false, TBL)
    vim.api.nvim_set_option_value("wrap", false, TBL)
    vim.api.nvim_set_option_value("relativenumber", false, TBL)
    vim.api.nvim_set_option_value("number", true, TBL)

    local fillchars = vim.api.nvim_get_option_value("fillchars", TBL)

    vim.api.nvim_set_option_value("fillchars", fillchars == "" and "eob: " or fillchars .. ",eob: ", TBL)

    vim.api.nvim_set_keymap("n", "1b", "<Plug>(BufOnly)", TBL)
    vim.api.nvim_set_keymap("n", "<C-w>m", "<Plug>(MaximizerToggle)", TBL)
    vim.api.nvim_set_keymap("n", "1t", "", { callback = function() vim.api.nvim_command("tabonly") end })
    vim.api.nvim_set_keymap("n", "<C-w>t", "", { callback = function() vim.api.nvim_command("tabedit %") end })
    vim.api.nvim_set_keymap("n", "<C-w><C-l>", "", { callback = function() vim.api.nvim_command("nohlsearch") end })
    vim.api.nvim_set_keymap("n", "<leader>to", "", { callback = function() vim.api.nvim_command("terminal") end })
  end,
}
