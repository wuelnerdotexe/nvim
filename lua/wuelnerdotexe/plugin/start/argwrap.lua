return {
  "FooSoft/vim-argwrap",
  keys = { { "J", function() vim.api.nvim_command("ArgWrap") end } },
  init = function()
    vim.api.nvim_set_var("argwrap_padded_braces", "[{")
    vim.api.nvim_set_var("argwrap_tail_comma", 1)
    vim.api.nvim_set_var("argwrap_tail_comma_braces", "{")
  end,
}
