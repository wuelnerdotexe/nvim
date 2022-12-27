local config = function()
  local set_option_value = vim.api.nvim_set_option_value
  local option_opts = {}

  set_option_value("winwidth", 6, option_opts)
  set_option_value("winminwidth", 6, option_opts)
  set_option_value("equalalways", false, option_opts)

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

  local set_keymap = vim.api.nvim_set_keymap
  local command = vim.api.nvim_command

  set_keymap("n", "<C-w>m", "", {
    callback = function()
      command("WindowsMaximize")
    end,
  })

  set_keymap("x", "<C-w>m", "", {
    callback = function()
      command("WindowsMaximize")
    end,
  })

  set_keymap("n", "<C-w>_", "", {
    callback = function()
      command("WindowsMaximizeVertically")
    end,
  })

  set_keymap("x", "<C-w>_", "", {
    callback = function()
      command("WindowsMaximizeVertically")
    end,
  })

  set_keymap("n", "<C-w>|", "", {
    callback = function()
      command("WindowsMaximizeHorizontally")
    end,
  })

  set_keymap("x", "<C-w>|", "", {
    callback = function()
      command("WindowsMaximizeHorizontally")
    end,
  })

  set_keymap("n", "<C-w>=", "", {
    callback = function()
      command("WindowsEqualize")
    end,
  })

  set_keymap("x", "<C-w>=", "", {
    callback = function()
      command("WindowsEqualize")
    end,
  })
end

return config
