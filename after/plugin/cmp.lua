if packer_plugins['nvim-cmp'] and packer_plugins['nvim-cmp'].loaded
then
  local vim_opt = vim.opt

  vim_opt.omnifunc = nil
  vim_opt.complete = nil
end

