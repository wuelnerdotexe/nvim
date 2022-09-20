if packer_plugins['human.vim'] and packer_plugins['human.vim'].loaded
then
  local vim_opt = vim.opt

  vim_opt.spell = false
  vim_opt.wrap = false
end

