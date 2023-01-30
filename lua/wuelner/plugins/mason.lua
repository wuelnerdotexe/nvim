return {
  "williamboman/mason.nvim",
  lazy = true,
  cmd = "Mason",
  config = function()
    require("mason").setup({ ui = { border = "rounded" } })
  end,
}
