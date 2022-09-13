local M = {}

M.config = function()
  local dashboard = require('dashboard')
  dashboard.custom_header = {
    '',
    ' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
    ' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
    ' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
    ' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
    ' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
    ' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
    '',
    '                  Powered by Enfocado                  ',
    ''
  }

  dashboard.custom_center = {
    {
      icon = ' ',
      desc = 'Load Session ',
      action = 'SessionLoad',
    },
    {
      icon = ' ',
      desc = 'New File     ',
      action = 'DashboardNewFile',
    },
    {
      icon = 'פּ ',
      desc = 'File Explorer',
      action = 'Fern .',
    },
    {
      icon = ' ',
      desc = 'Find File    ',
      action = 'FZF',
    }
  }

  dashboard.custom_footer = { 'https://github.com/wuelnerdotexe/nvim' }
  dashboard.session_directory = vim.env.HOME .. '/.cache/nvim/session'

  vim.api.nvim_create_autocmd('VimLeavePre', {
    pattern = '*', command = 'SessionSave'
  })
end

return M

