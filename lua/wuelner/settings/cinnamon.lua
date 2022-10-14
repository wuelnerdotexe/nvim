local M = {}

M.config = function()
  require("cinnamon").setup({
    extra_keymaps = true,
    extended_keymaps = true,
    override_keymaps = true,
    always_scroll = true,
    default_delay = 4,
    max_length = 300,
    scroll_limit = -1,
  })

  local keymap_set = vim.keymap.set

  keymap_set({ "n", "v" }, "<S-Up>", '<Cmd>lua Scroll("<C-b>", 1, 1)<CR>')
  keymap_set({ "n", "v" }, "<S-Down>", '<Cmd>lua Scroll("<C-f>", 1, 1)<CR>')
  keymap_set({ "n", "v" }, "k", function()
    return vim.v.count == 0 and "gk" or '<Cmd>lua Scroll("k", 0, 1)<CR>'
  end, { expr = true })
  keymap_set({ "n", "v" }, "j", function()
    return vim.v.count == 0 and "gj" or '<Cmd>lua Scroll("j", 0, 1)<CR>'
  end, { expr = true })
  keymap_set({ "n", "v" }, "<Up>", function()
    return vim.v.count == 0 and "g<Up>" or '<Cmd>lua Scroll("k", 0, 1)<CR>'
  end, { expr = true })
  keymap_set({ "n", "v" }, "<Down>", function()
    return vim.v.count == 0 and "g<Down>" or '<Cmd>lua Scroll("j", 0, 1)<CR>'
  end, { expr = true })
  keymap_set(
    { "n", "v" },
    "<ScrollWheelUp>",
    '<Cmd>lua Scroll("<ScrollWheelUp>")<CR>'
  )
  keymap_set(
    { "n", "v" },
    "<ScrollWheelDown>",
    '<Cmd>lua Scroll("<ScrollWheelDown>")<CR>'
  )
end

return M
