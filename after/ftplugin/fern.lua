vim.api.nvim_call_function("glyph_palette#apply", {})
vim.api.nvim_set_option_value("number", false, { buf = 0 })
vim.api.nvim_set_option_value("relativenumber", false, { buf = 0 })

vim.api.nvim_buf_set_keymap(0, "n", "q", "", {
  callback = function()
    vim.api.nvim_command("quit")
  end,
  nowait = true,
})

local keymap_opts = { nowait = true }

vim.api.nvim_buf_set_keymap(0, "n", "o", "<Plug>(fern-action-open)", keymap_opts)
vim.api.nvim_buf_set_keymap(0, "n", "<C-T>", "<Plug>(fern-action-open:tabedit)", keymap_opts)
vim.api.nvim_buf_set_keymap(0, "n", "<C-s>", "<Plug>(fern-action-open:split)", keymap_opts)
vim.api.nvim_buf_set_keymap(0, "n", "nf", "<Plug>(fern-action-new-file)", keymap_opts)
vim.api.nvim_buf_set_keymap(0, "n", "nd", "<Plug>(fern-action-new-dir)", keymap_opts)
vim.api.nvim_buf_set_keymap(0, "n", "m", "<Plug>(fern-action-move)", keymap_opts)
vim.api.nvim_buf_set_keymap(0, "n", "c", "<Plug>(fern-action-copy)", keymap_opts)
vim.api.nvim_buf_set_keymap(0, "n", "d", "<Plug>(fern-action-remove)", keymap_opts)
vim.api.nvim_buf_set_keymap(0, "n", "<F5>", "<Plug>(fern-action-reload)", keymap_opts)
vim.api.nvim_buf_set_keymap(0, "n", "g?", "<Plug>(fern-action-help)", keymap_opts)
vim.api.nvim_buf_set_keymap(0, "n", "?", "<Plug>(fern-action-help)", keymap_opts)
vim.api.nvim_buf_set_keymap(0, "n", "n", "<Plug>(fern-action-new-path)", {})

vim.api.nvim_buf_set_keymap(
  0,
  "n",
  "<",
  "<Plug>(fern-action-leave)<Plug>(fern-wait)<Plug>(fern-action-cd:root)<Cmd>pwd<CR>",
  keymap_opts
)

vim.api.nvim_buf_set_keymap(
  0,
  "n",
  ">",
  "<Plug>(fern-action-enter)<Plug>(fern-wait)<Plug>(fern-action-cd:root)<Cmd>pwd<CR>",
  keymap_opts
)

vim.api.nvim_buf_set_keymap(0, "n", "<CR>", "", {
  callback = function()
    return vim.api.nvim_call_function(
      "fern#smart#leaf",
      { "", "<Plug>(fern-action-expand:stay)", "<Plug>(fern-action-collapse)" }
    )
  end,
  nowait = true,
  expr = true,
  replace_keycodes = true,
})

vim.api.nvim_buf_set_keymap(0, "n", "<2-LeftMouse>", "", {
  callback = function()
    return vim.api.nvim_call_function(
      "fern#smart#leaf",
      { "", "<Plug>(fern-action-expand:stay)", "<Plug>(fern-action-collapse)" }
    )
  end,
  nowait = true,
  expr = true,
  replace_keycodes = true,
})

vim.api.nvim_buf_set_keymap(0, "n", "<C-v>", "", {
  callback = function()
    return vim.api.nvim_call_function(
      "fern#smart#drawer",
      { "<Plug>(fern-action-open:rightest)", "<Plug>(fern-action-open:vsplit)", "<Plug>(fern-action-open:vsplit)" }
    )
  end,
  nowait = true,
  expr = true,
  replace_keycodes = true,
})
