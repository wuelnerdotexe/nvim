local M = {}

M.setup = function()
  vim.g.matchup_matchparen_insert_timeout = 300
  vim.g.matchup_matchparen_deferred = 1
  vim.g.matchup_matchparen_deferred_show_delay = 40
  vim.g.matchup_matchparen_deferred_hide_delay = 0
  vim.g.matchup_matchparen_offscreen = { method = "popup" }
end

return M
