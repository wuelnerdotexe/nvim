return {
  "numToStr/Comment.nvim",
  keys = { { "gc", mode = { "n", "x" } } },
  dependencies = "JoosepAlviste/nvim-ts-context-commentstring",
  config = function()
    require("Comment").setup({
      toggler = { line = "gcc", block = "<Nop>" },
      opleader = { line = "gc", block = "<Nop>" },
      pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
    })
  end,
}
