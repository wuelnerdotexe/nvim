require('impatient')

local vim_g = vim.g

vim_g.do_filetype_lua = 1

local disable_plugins = {
  '2html_plugin',
  'bugreport',
  'compiler',
  'ftplugin',
  'getscript',
  'getscriptPlugin',
  'gzip',
  'logipat',
  'netrw',
  'netrwPlugin',
  'netrwSettings',
  'netrwFileHandlers',
  'matchit',
  'matchparen',
  'optwin',
  'rrhelper',
  'rplugin',
  'spellfile_plugin',
  'syntax',
  'synmenu',
  'tar',
  'tarPlugin',
  'tutor',
  'vimball',
  'vimballPlugin',
  'zip',
  'zipPlugin'
}

for _, plugin in pairs(disable_plugins) do
  vim_g['loaded_' .. plugin] = 1
end

local disable_providers = {
  'ruby',
  'node',
  'perl',
}

for _, provider in pairs(disable_providers) do
  vim_g['loaded_' .. provider .. '_provider'] = 0
end

require('plugins')

