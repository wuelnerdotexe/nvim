return {
  "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  event = { "BufNewFile", "BufRead", "BufAdd" },
  config = function()
    require("lsp_lines").setup()

    local toggle = require("lsp_lines").toggle

    vim.api.nvim_set_keymap("n", "<leader>lt", "", {
      callback = function()
        toggle()
      end,
    })
  end,
}
