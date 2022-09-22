local vim_fn = vim.fn
local vim_opt = vim.opt

if vim_fn.executable('rg') == 1
then
  vim_opt.grepprg = 'rg -i -. -g="' ..
    '!.git,!.svn,!.hg,!CSV,!.DS_Store,!Thumbs.db' ..
    '!node_modules,!bower_components,!*.code-search' ..
  '" --vimgrep'
end

if vim_fn.has('termguicolors') and vim_opt.termguicolors == true
then
  vim_opt.pumblend = 10
  vim_opt.winblend = 10
end

local signs = { Error = '●', Warn = '●', Info = '●', Hint = '●' }

for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type

  vim_fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
  virtual_text = { prefix = '▎' },
  float = {
    header = false,
    source = 'always',
    border = 'single'
  },
  update_in_insert = true,
  severity_sort = true
})

local keymap_set = vim.keymap.set

keymap_set('n', '1w', '<Cmd>only<CR>', { silent = true })
keymap_set('n', '1t', '<Cmd>tabonly<CR>', { silent = true })


