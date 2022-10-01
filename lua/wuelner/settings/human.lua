local M = {}

M.setup = function()
  vim.g.bufonly_exclude_filetypes = { 'fern', 'nerdterm' }
end

M.config = function()
  local vim_opt = vim.opt

  vim_opt.spell = false
  vim_opt.number = true
  if vim.fn.executable('rg') == 1
  then
    vim_opt.grepprg = 'rg -i -. -g="' ..
    '!.git,!.svn,!.hg,!CSV,!.DS_Store,!Thumbs.db' ..
    '!node_modules,!bower_components,!*.code-search' ..
    '" --vimgrep'
  end

  local keymap_set = vim.keymap.set

  keymap_set('n', '1w', '<Cmd>only<CR>', { silent = true })
  keymap_set('n', '1t', '<Cmd>tabonly<CR>', { silent = true })
  keymap_set('n', '1b', '<Plug>(BufOnly)')
  keymap_set('n', '<C-w>m', '<Plug>(MaximizerToggle)')
  keymap_set('n', '<leader>to', '<Cmd>terminal<CR>', { silent = true })
end

return M

