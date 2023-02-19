local M = {}

M.open_file_event = { "BufNewFile", "BufRead", "BufAdd" }

M.blend = 10

M.border = { style = "rounded", chars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" } }

M.uifiletypes = {
  "aerial",
  "checkhealth",
  "dap-repl",
  "dapui_breakpoints",
  "dapui_console",
  "dapui_hover",
  "dapui_scopes",
  "dapui_stacks",
  "dapui_watches",
  "DressingInput",
  "DressingSelect",
  "fern",
  "fern-replacer",
  "lazy",
  "lspinfo",
  "mason",
  "nerdterm",
  "noice",
  "null-ls-info",
  "qf",
  "TelescopePrompt",
}

M.kind_icons = {
  Array = "",
  Boolean = "",
  Class = "",
  Color = "",
  Constant = "",
  Constructor = "",
  Enum = "",
  EnumMember = "",
  Event = "",
  Field = "",
  File = "",
  Folder = "",
  Function = "",
  Interface = "",
  Key = "",
  Keyword = "",
  Method = "",
  Module = "",
  Namespace = "",
  Null = "ﳠ",
  Number = "",
  Object = "",
  Operator = "",
  Package = "",
  Property = "",
  Reference = "",
  Snippet = "",
  String = "",
  Struct = "",
  Text = "",
  TypeParameter = "",
  Unit = "",
  Value = "",
  Variable = "",
}

M.signs_priority = { smoothcursor = 11, diagnostic = 9, lightbulb = 8, git = 7 }

return M
