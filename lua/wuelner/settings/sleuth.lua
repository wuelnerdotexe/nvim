local M = {}

M.setup = function()
  local exclude_filetypes = {
    'aerial',
    'checkhealth',
    'fern',
    'fugitive',
    'fugitiveblame',
    'list',
    'lspinfo',
    'mason',
    'nerdterm',
    'packer',
    'qf',
    'TelescopePrompt'
  }

  for _, filetype in pairs(exclude_filetypes) do
    vim.g['sleuth_' .. filetype .. '_heuristics'] = 0
  end
end

return M

