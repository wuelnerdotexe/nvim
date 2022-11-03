local M = {}

M.config = function()
  require("mason").setup({
    max_concurrent_installers = 3,
    ui = {
      border = "rounded",
      icons = {
        package_installed = "✓",
        package_pending = "⟳",
        package_uninstalled = "-",
      },
    },
  })

  require("mason-lspconfig").setup({ automatic_installation = true })
end

return M
