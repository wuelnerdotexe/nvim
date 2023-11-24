return {
  "iamcco/markdown-preview.nvim",
  build = function() vim.api.nvim_call_function("mkdp#util#install", {}) end,
  ft = "markdown",
  init = function()
    vim.api.nvim_set_var("mkdp_auto_close", 0)
    vim.api.nvim_set_var("mkdp_refresh_slow", 1)
    vim.api.nvim_set_var("mkdp_browser", "firefox")
    vim.api.nvim_set_var("mkdp_echo_preview_url", 1)
    vim.api.nvim_set_var("mkdp_theme", "dark")
    vim.api.nvim_set_var("mkdp_combine_preview", 1)
  end,
}
