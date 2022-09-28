local M = {}

M.config = function()
  require('illuminate').configure({
    delay = 40,
    filetypes_denylist = {
      'checkhealth',
      'fern',
      'fugitive',
      'fugitiveblame',
      'fzf',
      'lspinfo',
      'mason',
      'nerdterm',
      'packer',
      'qf',
      'null-ls-info'
    },
    max_file_lines = 400
  })
end

return M

