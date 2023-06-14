return {
  "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  keys = {
    {
      "<leader>lt",
      function() require("lsp_lines").toggle() end,
      desc = "Language server: [t]oggle [l]ines diagnostic",
    },
  },
  event = "LspAttach",
  init = function()
    vim.api.nvim_create_autocmd("UIEnter", {
      callback = function() vim.diagnostic.config({ virtual_text = false, virtual_lines = false }) end,
    })
  end,
  config = function() require("lsp_lines").setup() end,
}
