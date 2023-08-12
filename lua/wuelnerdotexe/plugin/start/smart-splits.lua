return {
  "mrjones2014/smart-splits.nvim",
  keys = {
    { "<C-h>", function() require("smart-splits").move_cursor_left() end, mode = { "n", "x" } },
    { "<C-j>", function() require("smart-splits").move_cursor_down() end, mode = { "n", "x" } },
    { "<C-k>", function() require("smart-splits").move_cursor_up() end, mode = { "n", "x" } },
    { "<C-l>", function() require("smart-splits").move_cursor_right() end, mode = { "n", "x" } },
    { "<M-h>", function() require("smart-splits").resize_left() end, mode = { "n", "x" } },
    { "<M-j>", function() require("smart-splits").resize_down() end, mode = { "n", "x" } },
    { "<M-k>", function() require("smart-splits").resize_up() end, mode = { "n", "x" } },
    { "<M-l>", function() require("smart-splits").resize_right() end, mode = { "n", "x" } },
    { "<C-w>h", function() require("smart-splits").swap_buf_left() end, mode = { "n", "x" } },
    { "<C-w>j", function() require("smart-splits").swap_buf_down() end, mode = { "n", "x" } },
    { "<C-w>k", function() require("smart-splits").swap_buf_up() end, mode = { "n", "x" } },
    { "<C-w>l", function() require("smart-splits").swap_buf_right() end, mode = { "n", "x" } },
  },
  cmd = {
    "SmartCursorMoveDown",
    "SmartCursorMoveLeft",
    "SmartCursorMoveRight",
    "SmartCursorMoveUp",
    "SmartResizeDown",
    "SmartResizeLeft",
    "SmartResizeMode",
    "SmartResizeRight",
    "SmartResizeUp",
    "SmartSplitsLog",
    "SmartSplitsLogLevel",
  },
  init = function()
    vim.api.nvim_create_autocmd("UIEnter", {
      callback = function()
        vim.api.nvim_set_keymap("n", "<C-w><C-l>", "", { callback = function() vim.api.nvim_command("nohlsearch") end })
        vim.api.nvim_set_keymap("x", "<C-w><C-l>", "", { callback = function() vim.api.nvim_command("nohlsearch") end })
      end,
      once = true,
    })
  end,
  opts = function(_, opts)
    opts.ignored_buftypes = { "prompt" }

    opts.ignored_filetypes = vim.list_extend(opts.ignored_filetypes or {}, { "lazy" })

    opts.default_amount = 1

    opts.cursor_follows_swapped_bufs = true

    opts.multiplexer_integration = "tmux"
  end,
  config = function(_, opts) require("smart-splits").setup(opts) end,
}
