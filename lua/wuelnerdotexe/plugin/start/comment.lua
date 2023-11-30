return {
  {
    "numToStr/Comment.nvim",
    keys = { { "gc", mode = { "n", "x" } } },
    config = function()
      require("Comment").setup({
        toggler = { line = "gcc", block = "<Nop>" },
        opleader = { line = "gc", block = "<Nop>" },
        pre_hook = function(...)
          return require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()(...)
        end,
      })
    end,
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    lazy = true,
    init = function() vim.api.nvim_set_var("skip_ts_context_commentstring_module", true) end,
    config = function() require("ts_context_commentstring").setup({ enable_autocmd = false }) end,
  },
}
