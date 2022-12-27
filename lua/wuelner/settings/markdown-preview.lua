local setup = function()
  local set_var = vim.api.nvim_set_var

  set_var("mkdp_auto_close", 0)
  set_var("mkdp_refresh_slow", 1)
  set_var("mkdp_browser", "firefox")
  set_var("mkdp_echo_preview_url", 1)
  set_var("mkdp_theme", "dark")
end

return setup
