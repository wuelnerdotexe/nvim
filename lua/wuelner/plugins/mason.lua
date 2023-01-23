return {
  "williamboman/mason.nvim",
  lazy = true,
  cmd = "Mason",
  config = function()
    require("mason").setup({
      ui = {
        border = "rounded",
        icons = { package_installed = "✓", package_pending = "⟳", package_uninstalled = "-" },
      },
    })
  end,
}
