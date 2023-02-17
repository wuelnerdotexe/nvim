return {
  "andymass/vim-matchup",
  event = require("wuelnerdotexe.utils").plugins.open_file_event,
  init = function()
    vim.api.nvim_set_var("matchup_matchparen_timeout", 284)
    vim.api.nvim_set_var("matchup_matchparen_insert_timeout", 284)
    vim.api.nvim_set_var("matchup_matchparen_deferred", 1)
    vim.api.nvim_set_var("matchup_matchparen_deferred_show_delay", 42)
    vim.api.nvim_set_var("matchup_matchparen_deferred_hide_delay", 0)
    vim.api.nvim_set_var("matchup_matchparen_offscreen", { method = "popup" })
  end,
}
