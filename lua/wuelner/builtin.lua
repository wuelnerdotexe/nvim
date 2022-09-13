local g = vim.g

if vim.version().minor < 8 then
  g.do_filetype_lua = 1
  g.did_load_filetypes = 0
end

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
  g['loaded_' .. plugin] = 1
end

local disable_providers = {
  'ruby',
  'node',
  'perl',
}

for _, provider in pairs(disable_providers) do
  g['loaded_' .. provider .. '_provider'] = 0
end

