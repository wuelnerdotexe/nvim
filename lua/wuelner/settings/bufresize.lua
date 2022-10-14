local M = {}

M.config = function()
  require("bufresize").setup({
    register = {
      keys = {
        { "n", "<A-h>", "<A-h>", {} },
        { "n", "<A-j>", "<A-j>", {} },
        { "n", "<A-k>", "<A-k>", {} },
        { "n", "<A-l>", "<A-l>", {} },
        { "", "<LeftRelease>", "<LeftRelease>", {} },
        { "i", "<LeftRelease>", "<LeftRelease><C-o>", {} },
      },
      trigger_events = { "BufWinEnter", "WinEnter" },
    },
    resize = {
      keys = {},
      trigger_events = { "VimResized" },
      increment = false,
    },
  })
end

return M
