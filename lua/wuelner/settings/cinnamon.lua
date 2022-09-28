local M = {}

M.config = function()
  require('cinnamon').setup({
    extra_keymaps = true,
    extended_keymaps = true,
    override_keymaps = true,
    always_scroll = true,
    scroll_limit = -1
  })

  local keymap_set = vim.keymap.set

  keymap_set({ 'n', 'x' }, '<S-Up>', '<Cmd>lua Scroll("<C-b>", 1, 1)<CR>')
  keymap_set({ 'n', 'x' }, '<S-Down>', '<Cmd>lua Scroll("<C-f>", 1, 1)<CR>')
  keymap_set({ 'n', 'x' }, 'k', function()
    return vim.v.count == 0 and 'gk' or '<Cmd>lua Scroll("k", 0, 1)<CR>'
  end, { expr = true, silent = true })
  keymap_set({ 'n', 'x' }, 'j', function()
    return vim.v.count == 0 and 'gj' or '<Cmd>lua Scroll("j", 0, 1)<CR>'
  end, { expr = true, silent = true })
  keymap_set({ 'n', 'x' }, '<Up>', function()
    return vim.v.count == 0 and 'g<Up>' or '<Cmd>lua Scroll("k", 0, 1)<CR>'
  end, { expr = true, silent = true })
  keymap_set({ 'n', 'x' }, '<Down>', function()
    return vim.v.count == 0 and 'g<Down>' or '<Cmd>lua Scroll("j", 0, 1)<CR>'
  end, { expr = true, silent = true })

  keymap_set(
    { 'n', 'x' }, '<ScrollWheelUp>',
    '<Cmd>lua Scroll("<C-y>", 0, 1)<CR>'
  )

  keymap_set(
    { 'n', 'x' }, '<ScrollWheelDown>',
    '<Cmd>lua Scroll("<C-e>", 0, 1)<CR>'
  )

end

return M

