local M = {}

M.setup = function()
  if vim.fn.executable('rg') == 1
  then
    vim.opt.grepprg = 'rg -i -. -g="' ..
    '!.git,!.svn,!.hg,!CSV,!.DS_Store,!Thumbs.db' ..
    '!node_modules,!bower_components,!*.code-search' ..
    '" --vimgrep'
  end

  local keymap_set = vim.keymap.set

  keymap_set('n', '1w', '<Cmd>only<CR>', { silent = true })
  keymap_set('n', '1t', '<Cmd>tabonly<CR>', { silent = true })

  vim.g.bufonly_exclude_filetypes = { 'fern', 'nerdterm' }
end

M.config = function()
  local vim_opt = vim.opt

  vim_opt.spell = false
  vim_opt.number = true
  if vim.fn.has('termguicolors') and vim_opt.termguicolors == true
  then
    vim_opt.winblend = 10
    vim_opt.pumblend = 10
  end

  local keymap_set = vim.keymap.set

  keymap_set('n', '1b', '<Plug>(BufOnly)')
  keymap_set('n', '<C-h>', '<Plug>(ResizerLeft)')
  keymap_set('n', '<C-j>', '<Plug>(ResizerDown)')
  keymap_set('n', '<C-k>', '<Plug>(ResizerUp)')
  keymap_set('n', '<C-l>', '<Plug>(ResizerRight)')
  keymap_set('n', '<leader>mt', '<Plug>(MaximizerToggle)')
end

return M

