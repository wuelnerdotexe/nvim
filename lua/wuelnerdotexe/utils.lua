local M = {}
local sidebar_width

M.empty_table = {}

M.plugins = { open_file_event = { "BufNewFile", "BufRead", "BufAdd" } }

M.interface = {
  get_sidebar_width = function()
    if sidebar_width then
      return sidebar_width
    else
      local columns = vim.api.nvim_get_option_value("columns", M.empty_table)
      sidebar_width = math.floor((columns / (columns >= 160 and 3 or 2)) / 2)

      return sidebar_width
    end
  end,
  filetypes = {
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
  },
  blend = 10,
  border = { style = "rounded", chars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" } },
  codicons = {
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
  },
}

M.signs_priority = { smoothcursor = 11, diagnostic = 9, lightbulb = 8, git = 7 }

return M
