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
      "fern-replacer",
    })
  end,
  config = function()
    vim.api.nvim_set_option_value(
      "shortmess",
      vim.api.nvim_get_option_value("shortmess", require("wuelnerdotexe.plugin.utils").empty_table) .. "I",
      require("wuelnerdotexe.plugin.utils").empty_table
    )

    vim.api.nvim_set_option_value("wrap", false, require("wuelnerdotexe.plugin.utils").empty_table)
    vim.api.nvim_set_option_value("relativenumber", false, require("wuelnerdotexe.plugin.utils").empty_table)
    vim.api.nvim_set_option_value("number", true, require("wuelnerdotexe.plugin.utils").empty_table)

    local fillchars = vim.api.nvim_get_option_value("fillchars", require("wuelnerdotexe.plugin.utils").empty_table)

    vim.api.nvim_set_option_value(
      "fillchars",
      fillchars == "" and "eob: " or fillchars .. ",eob: ",
      require("wuelnerdotexe.plugin.utils").empty_table
    )

    vim.api.nvim_set_keymap("n", "1b", "<Plug>(BufOnly)", require("wuelnerdotexe.plugin.utils").empty_table)
    vim.api.nvim_set_keymap("n", "1t", "", { callback = function() vim.api.nvim_command("tabonly") end })
    vim.api.nvim_set_keymap("n", "<C-w>t", "", { callback = function() vim.api.nvim_command("tabedit %") end })
    vim.api.nvim_set_keymap("n", "<C-w>m", "<Plug>(MaximizerToggle)", require("wuelnerdotexe.plugin.utils").empty_table)
    vim.api.nvim_set_keymap("n", "<leader>to", "", { callback = function() vim.api.nvim_command("terminal") end })
    vim.api.nvim_set_keymap("n", "<C-w><C-l>", ':nohlsearch<C-R>=has("diff") ? "<Bar>diffupdate" : ""<CR><CR><C-l>', {
      noremap = true,
      silent = true,
    })
  end,
}
