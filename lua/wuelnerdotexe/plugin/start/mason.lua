return {
  "williamboman/mason.nvim",
  build = ":MasonUpdate",
  cmd = { "Mason", "MasonInstall", "MasonLog", "MasonUninstall", "MasonUninstallAll", "MasonUpdate" },
  lazy = true,
  config = function()
    require("mason").setup({ ui = { border = require("wuelnerdotexe.plugin.config").border and "rounded" or "shadow" } })
  end,
}
