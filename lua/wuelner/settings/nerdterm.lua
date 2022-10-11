local M = {}

M.config = function()
  vim.keymap.set("n", "<leader>tt", function()
    require("wuelner.utils").BufresizeToggle("NERDTermToggle", "nerdterm")
  end)
end

return M
