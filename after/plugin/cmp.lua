if packer_plugins['nvim-cmp'].loaded then
  local opt = vim.opt

  opt.omnifunc = ''
  opt.complete = ''
end

