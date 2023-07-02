local M = {}

M.completion_icons = {
  Text = " ",
  Method = " ",
  Function = " ",
  Constructor = " ",
  Field = " ",
  Variable = " ",
  Class = " ",
  Interface = " ",
  Module = " ",
  Property = " ",
  Unit = " ",
  Value = " ",
  Enum = " ",
  Keyword = " ",
  Snippet = " ",
  Color = " ",
  File = " ",
  Reference = " ",
  Folder = " ",
  EnumMember = " ",
  Constant = " ",
  Struct = " ",
  Event = " ",
  Operator = " ",
  TypeParameter = " ",
}

M.formatting = {
  fields = { "abbr", "kind" },
  format = function(entry, vim_item)
    vim_item.kind = M.completion_icons[vim_item.kind] .. vim_item.kind

    return vim_item
  end,
}

return M
