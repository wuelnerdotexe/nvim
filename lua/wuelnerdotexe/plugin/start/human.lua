return {
  "wuelnerdotexe/human.vim",
  priority = 10000,
  lazy = false,
  init = function()
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = function() vim.api.nvim_set_hl(0, "Whitespace", { link = "DiagnosticError" }) end,
    })
  end,
  config = function()
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
