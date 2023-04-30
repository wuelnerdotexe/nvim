return {
  "andymass/vim-matchup",
  event = require("wuelnerdotexe.plugin.config").open_file_event,
  dependencies = "nvim-treesitter/nvim-treesitter",
  init = function()
    vim.api.nvim_set_var("matchup_motion_enabled", 0)
    vim.api.nvim_set_var("matchup_text_obj_enabled", 0)
    vim.api.nvim_set_var("matchup_delim_stopline", 1000)
    vim.api.nvim_set_var("matchup_matchparen_fallback", 0)
    vim.api.nvim_set_var("matchup_matchparen_timeout", 284)
    vim.api.nvim_set_var("matchup_matchparen_insert_timeout", 284)
    vim.api.nvim_set_var("matchup_matchparen_deferred", 1)
    vim.api.nvim_set_var("matchup_matchparen_deferred_show_delay", 42)
    vim.api.nvim_set_var("matchup_matchparen_deferred_hide_delay", 0)
    vim.api.nvim_set_var("matchup_matchparen_offscreen", { method = "popup" })
  end,
}
