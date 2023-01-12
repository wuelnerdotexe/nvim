require("bufferline").setup({
  options = {
    max_name_length = 14,
    max_prefix_length = 14,
    tab_size = 18,
    indicator = { icon = "▎", style = "icon" },
    offsets = {
      { filetype = "aerial", text = "OUTLINE EXPLORER", highlight = "Title", separator = false },
      { filetype = "fern", text = "FOLDERS EXPLORER", highlight = "Title", separator = false },
    },
    show_buffer_icons = false,
    show_buffer_default_icon = false,
    show_close_icon = false,
    separator_style = { "▎", "▎" },
  },
})

require("bufferline-cycle-windowless").setup({ default_enabled = true })

local set_keymap = vim.api.nvim_set_keymap
local command = vim.api.nvim_command

set_keymap("n", "<S-Home>", "", {
  callback = function()
    command("BufferLineMovePrev")
  end,
})

set_keymap("n", "gB", "", {
  callback = function()
    command("BufferLineCycleWindowlessPrev")
  end,
})

set_keymap("n", "<S-PageUp>", "", {
  callback = function()
    command("BufferLineCycleWindowlessPrev")
  end,
})

set_keymap("i", "<S-PageUp>", "", {
  callback = function()
    command("BufferLineCycleWindowlessPrev")
  end,
})

set_keymap("n", "<S-End>", "", {
  callback = function()
    command("BufferLineMoveNext")
  end,
})

set_keymap("n", "gb", "", {
  callback = function()
    command("BufferLineCycleWindowlessNext")
  end,
})

set_keymap("n", "<S-PageDown>", "", {
  callback = function()
    command("BufferLineCycleWindowlessNext")
  end,
})

set_keymap("i", "<S-PageDown>", "", {
  callback = function()
    command("BufferLineCycleWindowlessNext")
  end,
})
