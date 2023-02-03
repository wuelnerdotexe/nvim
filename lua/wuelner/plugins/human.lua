return {
  "wuelnerdotexe/human.vim",
  lazy = false,
  init = function()
    vim.api.nvim_set_var("bufonly_exclude_buftypes", { "terminal" })
    vim.api.nvim_set_var("bufonly_exclude_filetypes", {
      "aerial",
      "dap-repl",
      "dapui_breakpoints",
      "dapui_console",
      "dapui_scopes",
      "dapui_stacks",
      "dapui_watches",
      "DressingInput",
      "DressingSelect",
      "fern",
      "notify",
    })
  end,
  config = function()
    local option_opts = {}

    vim.api.nvim_set_option_value(
      "shortmess",
      vim.api.nvim_get_option_value("shortmess", option_opts) .. "I",
      option_opts
    )

    vim.api.nvim_set_option_value("spell", false, option_opts)
    vim.api.nvim_set_option_value("wrap", false, option_opts)
    vim.api.nvim_set_option_value("relativenumber", false, option_opts)
    vim.api.nvim_set_option_value("number", true, option_opts)

    local fillchars = vim.api.nvim_get_option_value("fillchars", option_opts)

    vim.api.nvim_set_option_value("fillchars", fillchars == "" and "eob: " or fillchars .. ",eob: ", option_opts)

    vim.api.nvim_set_keymap("n", "1b", "<Plug>(BufOnly)", {})
    vim.api.nvim_set_keymap("n", "<C-w>m", "<Plug>(MaximizerToggle)", {})
    vim.api.nvim_set_keymap("n", "<C-w><C-l>", ':nohlsearch<C-R>=has("diff") ? "<Bar>diffupdate" : ""<CR><CR><C-l>', {
      noremap = true,
      silent = true,
    })

    vim.api.nvim_set_keymap("n", "1t", "", {
      callback = function()
        vim.api.nvim_command("tabonly")
      end,
    })

    vim.api.nvim_set_keymap("n", "<C-w>t", "", {
      callback = function()
        vim.api.nvim_command("tabedit %")
      end,
    })

    vim.api.nvim_set_keymap("n", "<leader>to", "", {
      callback = function()
        vim.api.nvim_command("terminal")
      end,
    })
  end,
}
