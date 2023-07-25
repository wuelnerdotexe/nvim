return {
  {
    "numToStr/Comment.nvim",
    keys = { { "gc", mode = { "n", "x" } } },
    config = function()
      require("Comment").setup({
        toggler = { line = "gcc", block = "<Nop>" },
        opleader = { line = "gc", block = "<Nop>" },
        pre_hook = function(ctx) return require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()(ctx) end,
      })
    end,
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      opts = { context_commentstring = { enable = true, enable_autocmd = false } },
    },
    lazy = true,
  },
}
