local config = function()
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

  local keymap_set = vim.keymap.set

  keymap_set("n", "<S-Home>", "<Cmd>BufferLineMovePrev<CR>")
  keymap_set("n", "gB", "<Cmd>BufferLineCyclePrev<CR>")
  keymap_set("n", "<S-PageUp>", "<Cmd>BufferLineCyclePrev<CR>")
  keymap_set("i", "<S-PageUp>", "<Cmd>BufferLineCyclePrev<CR>")
  keymap_set("n", "<S-End>", "<Cmd>BufferLineMoveNext<CR>")
  keymap_set("n", "gb", "<Cmd>BufferLineCycleNext<CR>")
  keymap_set("n", "<S-PageDown>", "<Cmd>BufferLineCycleNext<CR>")
  keymap_set("i", "<S-PageDown>", "<Cmd>BufferLineCycleNext<CR>")
end

return config
