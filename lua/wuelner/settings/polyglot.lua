local M = {}

M.setup = function()
  vim.g.did_load_filetypes = nil
  vim.g.polyglot_disabled = { "autoindent", "ftdetect", "sensible" }
  vim.g.vim_jsx_pretty_highlight_close_tag = 1
  vim.g.vim_jsx_pretty_colorful_config = 1
end

M.config = function()
  vim.g.did_load_filetypes = nil
  vim.api.nvim_create_autocmd("VimEnter", { command = "set regexpengine=0" })
end

return M
