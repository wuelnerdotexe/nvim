return {
  "wuelnerdotexe/human.vim",
  lazy = false,
  priority = 10000,
  init = function()
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = function() vim.api.nvim_command("highlight! link Whitespace DiagnosticVirtualTextError") end,
    })

    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        for option, value in pairs(require("wuelnerdotexe.plugin.util").plugin_options) do
          require("wuelnerdotexe.plugin.util").set_option(option, value)
        end

        return true
      end,
      once = true,
    })

    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        vim.api.nvim_set_keymap("n", "1b", "<Plug>(BufOnly)", TBL)
        vim.api.nvim_set_keymap("n", "<C-w>m", "<Plug>(MaximizerToggle)", TBL)
        vim.api.nvim_set_keymap("n", "<C-w>t", "", { callback = function() vim.api.nvim_command("tabedit %") end })
        vim.api.nvim_set_keymap("n", "<C-w><C-l>", "", { callback = function() vim.api.nvim_command("nohlsearch") end })
        vim.api.nvim_set_keymap("n", "<leader>to", "", { callback = function() vim.api.nvim_command("terminal") end })
        vim.api.nvim_set_keymap("n", "1t", "", { callback = function() vim.api.nvim_command("tabonly") end })

        return true
      end,
      once = true,
    })

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
      "spectre_panel",
    })
  end,
}
