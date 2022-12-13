local M = {}

M.setup = function()
  vim.g.bufonly_exclude_buftypes = { "terminal" }
  vim.g.bufonly_exclude_filetypes = {
    "aerial",
    "dap-repl",
    "dapui_breakpoints",
    "dapui_console",
    "dapui_scopes",
    "dapui_stacks",
    "dapui_watches",
    "fern",
    "notify",
  }
end

M.config = function()
  vim.opt.spell = false
  vim.opt.wrap = false
  vim.opt.relativenumber = false
  vim.opt.number = true
  vim.opt.fillchars:append({ eob = " " })

  local keymap_set = vim.keymap.set

  keymap_set("n", "1b", "<Plug>(BufOnly)")
  keymap_set("n", "1t", "<Cmd>tabonly<CR>")
  keymap_set("n", "<C-w>t", "<Cmd>tabedit %<CR>")
  keymap_set("n", "<leader>to", "<Cmd>terminal<CR>")
  keymap_set(
    "n",
    "<C-w><C-l>",
    ':nohlsearch<C-R>=has("diff") ? "<Bar>diffupdate" : ""<CR><CR><C-l>',
    { noremap = true, silent = true }
  )
end

return M
