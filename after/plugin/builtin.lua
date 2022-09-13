local opt = vim.opt
local fn = vim.fn
local keymap = vim.keymap

if fn.has('termguicolors') and opt.termguicolors == true then
  opt.pumblend = 10
  opt.winblend = 10
end

local signs = { Error = '●', Warn = '●', Info = '●', Hint = '●' }

for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type

  fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
  virtual_text = { prefix = '▎' },
  float = {
    header = false,
    source = 'always',
    border = 'single'
  },
  update_in_insert = false,
  severity_sort = true
})

local opts = { silent = true }

keymap.set('n', '<leader>ns', '<Cmd>vsplit<CR>', opts)
keymap.set('n', '<leader>nt', '<Cmd>tabedit<CR>', opts)

