local M = {}

M.setup = function()
  local vim_g = vim.g

  vim_g.bufonly_exclude_buftypes = { "terminal" }
  vim_g.bufonly_exclude_filetypes = {
    "aerial",
    "dap-repl",
    "dapui_breakpoints",
    "dapui_console",
    "dapui_scopes",
    "dapui_stacks",
    "dapui_watches",
    "fern",
  }
end

M.config = function()
  local vim = vim
  local vim_opt = vim.opt

  vim_opt.spell = false
  vim_opt.foldenable = false

  local keymap_set = vim.keymap.set

  keymap_set("n", "1b", "<Plug>(BufOnly)")
  keymap_set("n", "1t", "<Cmd>tabonly<CR>", { silent = true })
  keymap_set("n", "<C-w>t", "<Cmd>tabedit %<CR>", { silent = true })
  keymap_set("n", "<leader>to", "<Cmd>tabnew +terminal<CR>", {
    silent = true,
  })
  keymap_set(
    "n",
    "<C-w><C-l>",
    ':nohlsearch<C-R>=has("diff")?"<Bar>diffupdate":""<CR><CR><C-l>',
    { noremap = true, silent = true }
  )
end

return M
