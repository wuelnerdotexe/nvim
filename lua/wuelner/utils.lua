local M = {}

M.bufresize_toggle = function(command, filetype)
  local bufresize = require("bufresize")
  local nvim_command = vim.api.nvim_command

  if vim.bo.filetype == filetype then
    bufresize.block_register()
    nvim_command(command)
    bufresize.resize_close()
  else
    bufresize.block_register()
    nvim_command(command)
    bufresize.resize_open()
  end
end

M.aerial_breadcrumbs = function()
  local symbols = require("aerial").get_location(true)
  local depth = nil or #symbols
  local table_unpack = table.unpack

  if depth > 0 then
    symbols = { table_unpack(symbols, 1, depth) }
  else
    symbols = { table_unpack(symbols, #symbols + 1 + depth) }
  end

  local parts = {}

  for _, symbol in ipairs(symbols) do
    table.insert(parts, string.format("%s %s", symbol.icon, symbol.name))
  end

  local table_concat = table.concat

  return table_concat(parts, " > ") == "" and "..."
    or table_concat(parts, " > ")
end

return M
