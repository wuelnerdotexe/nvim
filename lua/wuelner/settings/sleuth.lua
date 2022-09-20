local M = {}

M.setup = function()
  local exclude_filetypes = {
    'checkhealth',
    'fern',
    'fugitive',
    'fugitiveblame',
    'fzf',
    'list',
    'lspinfo',
    'mason',
    'nerdterm',
    'packer',
    'qf'
  }

  for _, filetype in pairs(exclude_filetypes) do
    vim.g['sleuth_' .. filetype .. '_heuristics'] = 0
  end
end

return M

