local M = {}

M.config = function()
  require("bufferline").setup({
    options = {
      buffer_close_icon = "",
      indicator = { icon = "▊", style = "icon" },
      offsets = {
        {
          filetype = "aerial",
          text = "OUTLINE EXPLORER",
          highlight = "Title",
          separator = false,
        },
        {
          filetype = "fern",
          text = "FOLDERS EXPLORER",
          highlight = "Title",
          separator = false,
        },
      },
      separator_style = "thick",
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

return M
