local config = function()
  vim.opt.winwidth = 6
  vim.opt.winminwidth = 6
  vim.opt.equalalways = false

  require("windows").setup({
    autowidth = { enable = false, winwidth = 3, filetype = {} },
    ignore = {
      buftype = { "loclist", "prompt", "quickfix" },
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
        "noice",
        "notify",
        "null-ls-info",
        "packer",
        "qf",
        "TelescopePrompt",
      },
    },
    animation = { fps = 24 },
  })

  local keymap_set = vim.keymap.set
  local keymap_mode = { "n", "x" }

  keymap_set(keymap_mode, "<C-w>m", "<Cmd>WindowsMaximize<CR>")
  keymap_set(keymap_mode, "<C-w>_", "<Cmd>WindowsMaximizeVertically<CR>")
  keymap_set(keymap_mode, "<C-w>|", "<Cmd>WindowsMaximizeHorizontally<CR>")
  keymap_set(keymap_mode, "<C-w>=", "<Cmd>WindowsEqualize<CR>")
end

return config
