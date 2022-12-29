local M = {}

M.setup = function()
  local set_var = vim.api.nvim_set_var

  set_var("did_load_filetypes", nil)
  set_var("polyglot_disabled", { "autoindent", "ftdetect", "sensible" })
  set_var("vim_jsx_pretty_highlight_close_tag", 1)
  set_var("vim_jsx_pretty_colorful_config", 1)
end

M.config = function()
  vim.api.nvim_set_var("did_load_filetypes", nil)
  vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
      vim.api.nvim_set_option_value("regexpengine", 0, {})
    end,
  })
end

return M
