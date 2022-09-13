local M = {}

M.setup = function()
  local exclude_filetypes = {
    'checkhealth',
    'dashboard',
    'fern',
    'fugitive',
    'fugitiveblame',
    'lspinfo',
    'mason',
    'packer'
  }

  for _, filetype in pairs(exclude_filetypes) do
    vim.g['sleuth_' .. filetype .. '_heuristics'] = 0
  end
end

return M

