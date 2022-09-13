local M = {}

M.setup = function()
  local g = vim.g

  g.user_emmet_install_global = 0
  g.user_emmet_settings = {
    javascript = { extends = 'jsx' },
    typescript = { extends = 'tsx' }
  }

  vim.api.nvim_create_autocmd('FileType', {
    pattern = 'html,css,javascriptreact,typescriptreact',
    command = 'EmmetInstall'
  })
end

return M
