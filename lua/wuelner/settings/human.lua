local M = {}

M.setup = function()
  local set_var = vim.api.nvim_set_var

  set_var("bufonly_exclude_buftypes", { "terminal" })
  set_var("bufonly_exclude_filetypes", {
    "aerial",
    "dap-repl",
    "dapui_breakpoints",
    "dapui_console",
    "dapui_scopes",
    "dapui_stacks",
    "dapui_watches",
    "fern",
    "notify",
  })
end

M.config = function()
  local set_option_value = vim.api.nvim_set_option_value
  local option_opts = {}

  set_option_value("spell", false, option_opts)
  set_option_value("wrap", false, option_opts)
  set_option_value("relativenumber", false, option_opts)
  set_option_value("number", true, option_opts)

  local fillchars = vim.api.nvim_get_option_value("fillchars", option_opts)

  set_option_value("fillchars", fillchars == "" and "eob: " or fillchars .. ",eob: ", option_opts)

  local set_keymap = vim.api.nvim_set_keymap

  set_keymap("n", "1b", "<Plug>(BufOnly)", {})

  local command = vim.api.nvim_command

  set_keymap("n", "1t", "", {
    callback = function()
      command("tabonly")
    end,
  })

  set_keymap("n", "<C-w>t", "", {
    callback = function()
      command("tabedit %")
    end,
  })

  set_keymap("n", "<leader>to", "", {
    callback = function()
      command("terminal")
    end,
  })

  set_keymap("n", "<C-w><C-l>", ':nohlsearch<C-R>=has("diff") ? "<Bar>diffupdate" : ""<CR><CR><C-l>', {
    noremap = true,
    silent = true,
  })
end

return M
