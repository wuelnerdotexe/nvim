return {
  "andymass/vim-matchup",
  event = { "BufNewFile", "BufRead", "BufAdd" },
  init = function()
    vim.api.nvim_set_var("matchup_matchparen_insert_timeout", 300)
    vim.api.nvim_set_var("matchup_matchparen_deferred", 1)
    vim.api.nvim_set_var("matchup_matchparen_deferred_show_delay", 40)
    vim.api.nvim_set_var("matchup_matchparen_deferred_hide_delay", 0)
    vim.api.nvim_set_var("matchup_matchparen_offscreen", { method = "popup" })
  end,
}
