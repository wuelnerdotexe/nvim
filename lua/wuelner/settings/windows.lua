local M = {}

M.config = function()
  local vim_opt = vim.opt

  vim_opt.winwidth = 6
  vim_opt.winminwidth = 6
  vim_opt.equalalways = false

  require("windows").setup({
    autowidth = { enable = false, winwidth = 3, filetype = {} },
    ignore = {
      buftype = { "loclist", "prompt", "quickfix", "terminal" },
      filetype = {
        "aerial",
        "checkhealth",
        "dap-repl",
        "dapui_breakpoints",
        "dapui_console",
        "dapui_hover",
        "dapui_scopes",
        "dapui_stacks",
        "dapui_watches",
        "fern",
        "lspinfo",
        "mason",
        "nerdterm",
        "null-ls-info",
        "packer",
        "qf",
        "TelescopePrompt",
      },
    },
    animation = { fps = 24 },
  })

  local keymap_set = vim.keymap.set

  keymap_set("n", "<C-w>m", "<Cmd>WindowsMaximize<CR>", {
    silent = true,
  })
  keymap_set("n", "<C-w>_", "<Cmd>WindowsMaximizeVertically<CR>", {
    silent = true,
  })
  keymap_set("n", "<C-w>|", "<Cmd>WindowsMaximizeHorizontally<CR>", {
    silent = true,
  })
  keymap_set("n", "<C-w>=", "<Cmd>WindowsEqualize<CR>", {
    silent = true,
  })
end

return M
