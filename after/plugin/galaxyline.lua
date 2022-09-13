if packer_plugins['galaxyline.nvim'].loaded then
  local opt = vim.opt

  opt.showmode = false
  opt.ruler = false
  opt.laststatus = 2
end

