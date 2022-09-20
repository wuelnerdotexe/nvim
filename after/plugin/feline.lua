if packer_plugins['feline.nvim'] and packer_plugins['feline.nvim'].loaded
then
  local vim_opt = vim.opt

  vim_opt.ruler = false
  vim_opt.laststatus = 2
end

