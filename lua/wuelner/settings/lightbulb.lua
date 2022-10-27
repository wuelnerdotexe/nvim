local M = {}

M.config = function()
  require("nvim-lightbulb").setup({
    sign = { priority = 9 },
    autocmd = { enabled = true },
  })

  vim.fn.sign_define(
    "LightBulbSign",
    { text = "", texthl = "DiagnosticSignInfo", linehl = "", numhl = "" }
  )
end

return M
