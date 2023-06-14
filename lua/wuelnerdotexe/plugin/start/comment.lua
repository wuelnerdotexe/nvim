return {
  "numToStr/Comment.nvim",
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      opts = function(_, opts) opts.context_commentstring = { enable = true, enable_autocmd = false } end,
    },
  },
  keys = { { "gc", mode = { "n", "x" } } },
  config = function()
    require("Comment").setup({
      toggler = { line = "gcc", block = "<Nop>" },
      opleader = { line = "gc", block = "<Nop>" },
      pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
    })
  end,
}
