local M = {}

M.aerial_breadcrumbs = function()
  local symbols = require("aerial").get_location(true)
  local depth = nil or #symbols
  local table = table
  local table_unpack = table.unpack

  symbols = depth > 0 and { table_unpack(symbols, 1, depth) }
    or { table_unpack(symbols, #symbols + 1 + depth) }

  local parts = {}

  for _, symbol in ipairs(symbols) do
    table.insert(parts, string.format("%s %s", symbol.icon, symbol.name))
  end

  local table_concat = table.concat

  return table_concat(parts, " > ") == "" and "..."
    or table_concat(parts, " > ")
end

return M
