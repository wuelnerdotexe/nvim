local M = {}

M.config = function()
  require('cmp_tabnine.config').setup({
    ignored_file_types = {
      ['checkhealth'] = true,
      ['fern'] = true,
      ['fugitive'] = true,
      ['fugitiveblame'] = true,
      ['fzf'] = true,
      ['lspinfo'] = true,
      ['mason'] = true,
      ['nerdterm'] = true,
      ['packer'] = true,
      ['qf'] = true,
      ['null-ls-info'] = true
    }
  })
end

return M

