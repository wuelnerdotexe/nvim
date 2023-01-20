return {
  "kosayoda/nvim-lightbulb",
  event = { "BufNewFile", "BufRead", "BufAdd" },
  config = function()
    require("nvim-lightbulb").setup({ sign = { priority = 8 }, autocmd = { enabled = true } })

    vim.api.nvim_call_function(
      "sign_define",
      { "LightBulbSign", { text = "", texthl = "DiagnosticSignInfo", linehl = "", numhl = "" } }
    )
  end,
}
