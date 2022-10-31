local M = {}

M.setup = function()
  vim.g.mkdp_auto_close = 0
  vim.g.mkdp_refresh_slow = 1
  vim.g.mkdp_browser = "firefox"
  vim.g.mkdp_echo_preview_url = 1
  vim.g.mkdp_theme = "dark"
end

return M
