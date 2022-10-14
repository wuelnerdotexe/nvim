local M = {}

M.setup = function()
  vim.g.bufonly_exclude_filetypes = { "aerial", "fern", "nerdterm" }
end

M.config = function()
  vim.opt.spell = false

  local keymap_set = vim.keymap.set

  keymap_set("n", "1b", "<Plug>(BufOnly)")
  keymap_set("n", "1t", "<Cmd>tabonly<CR>", { silent = true })
  keymap_set("n", "<C-w>t", "<Cmd>tabedit %<CR>", { silent = true })
  keymap_set("n", "<leader>to", "<Cmd>terminal<CR>", { silent = true })
  keymap_set(
    "n",
    "<C-w><C-l>",
    ':nohlsearch<C-R>=has("diff")?"<Bar>diffupdate":""<CR><CR><C-l>',
    { noremap = true, silent = true }
  )
end

return M
