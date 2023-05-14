local mode = { "n", "x" }

return {
  "mrjones2014/smart-splits.nvim",
  keys = {
    { "<C-h>", function() require("smart-splits").move_cursor_left() end, mode = mode },
    { "<C-j>", function() require("smart-splits").move_cursor_down() end, mode = mode },
    { "<C-k>", function() require("smart-splits").move_cursor_up() end, mode = mode },
    { "<C-l>", function() require("smart-splits").move_cursor_right() end, mode = mode },
    { "<M-h>", function() require("smart-splits").resize_left() end, mode = mode },
    { "<M-j>", function() require("smart-splits").resize_down() end, mode = mode },
    { "<M-k>", function() require("smart-splits").resize_up() end, mode = mode },
    { "<M-l>", function() require("smart-splits").resize_right() end, mode = mode },
    { "<C-w>h", function() require("smart-splits").swap_buf_left() end, mode = mode },
    { "<C-w>j", function() require("smart-splits").swap_buf_down() end, mode = mode },
    { "<C-w>k", function() require("smart-splits").swap_buf_up() end, mode = mode },
    { "<C-w>l", function() require("smart-splits").swap_buf_right() end, mode = mode },
  },
  config = function()
    require("smart-splits").setup({
      ignored_filetypes = {
        "dapui_hover",
        "DressingInput",
        "DressingSelect",
        "lazy",
        "lspinfo",
        "mason",
        "null-ls-info",
        "TelescopePrompt",
      },
      ignored_buftypes = { "prompt" },
      default_amount = 1,
      cursor_follows_swapped_bufs = true,
      multiplexer_integration = "tmux",
    })
  end,
}
