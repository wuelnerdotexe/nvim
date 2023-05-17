return {
  "wuelnerdotexe/human.vim",
  lazy = false,
  priority = 10000,
  config = function()
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = function() vim.api.nvim_command("highlight! link Whitespace DiagnosticError") end,
    })

    vim.api.nvim_create_autocmd("UIEnter", {
      callback = function()
        for option, value in pairs(require("wuelnerdotexe.plugin.util").plugin_options) do
          require("wuelnerdotexe.plugin.util").set_option(option, value)
        end

        vim.api.nvim_set_keymap("n", "<C-w>t", "", { callback = function() vim.api.nvim_command("tabedit %") end })
        vim.api.nvim_set_keymap("n", "<C-w><C-l>", "", { callback = function() vim.api.nvim_command("nohlsearch") end })
        vim.api.nvim_set_keymap("n", "<leader>to", "", {
          callback = function() vim.api.nvim_command("terminal") end,
          desc = "General: [o]pen the [t]erminal in a new buffer",
        })
      end,
      once = true,
    })
  end,
}
