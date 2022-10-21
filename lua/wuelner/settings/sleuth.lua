local M = {}

M.setup = function()
  local exclude_filetypes = {
    "aerial",
    "checkhealth",
    "dapui_breakpoints",
    "dapui_console",
    "dapui_hover",
    "dapui_scopes",
    "dapui_stacks",
    "dapui_watches",
    "fern",
    "list",
    "lspinfo",
    "mason",
    "nerdterm",
    "packer",
    "qf",
    "TelescopePrompt",
  }

  for _, filetype in pairs(exclude_filetypes) do
    vim.g["sleuth_" .. filetype .. "_heuristics"] = 0
  end
end

return M
