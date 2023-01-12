require("lsp_lines").setup()

vim.api.nvim_set_keymap("n", "<leader>lt", "", {
  callback = function()
    require("lsp_lines").toggle()
  end,
})
