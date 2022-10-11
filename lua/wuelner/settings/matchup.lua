local M = {}

M.setup = function()
  local vim_g = vim.g

  vim_g.matchup_matchparen_insert_timeout = 300
  vim_g.matchup_matchparen_deferred = 1
  vim_g.matchup_matchparen_deferred_show_delay = 40
  vim_g.matchup_matchparen_deferred_hide_delay = 0
  vim_g.matchup_matchparen_offscreen = { method = 'popup' }
end

return M

