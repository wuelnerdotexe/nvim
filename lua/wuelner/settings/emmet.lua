local M = {}

M.setup = function()
  local vim_g = vim.g

  vim_g.user_emmet_install_global = 0
  vim_g.user_emmet_settings = {
    javascript = { extends = "jsx" },
    typescript = { extends = "tsx" },
  }
end

M.config = function()
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "html,css,javascriptreact,typescriptreact",
    command = "EmmetInstall",
  })
end

return M
