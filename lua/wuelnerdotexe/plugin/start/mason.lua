return {
  "williamboman/mason.nvim",
  build = ":MasonUpdate",
  cmd = { "Mason", "MasonInstall", "MasonLog", "MasonUninstall", "MasonUninstallAll", "MasonUpdate" },
  lazy = true,
  init = function()
    require("wuelnerdotexe.plugin.util").add_colorscheme_integration("mason")

    table.insert(require("wuelnerdotexe.plugin.util").user_interface_filetypes, "mason")
  end,
  config = function() require("mason").setup({ ui = { border = "rounded" } }) end,
}
