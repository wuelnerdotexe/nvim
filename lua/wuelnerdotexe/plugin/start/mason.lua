return {
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    cmd = { "Mason", "MasonInstall", "MasonLog", "MasonUninstall", "MasonUninstallAll", "MasonUpdate" },
    lazy = true,
    init = function()
      require("wuelnerdotexe.plugin.util").add_colorscheme_integration("mason")

      table.insert(require("wuelnerdotexe.plugin.util").user_interface_filetypes, "mason")
    end,
    config = function() require("mason").setup({ ui = { border = "rounded" } }) end,
  },
  {
    "mrjones2014/smart-splits.nvim",
    optional = true,
    opts = function(_, opts) opts.ignored_filetypes = vim.list_extend(opts.ignored_filetypes or {}, { "mason" }) end,
  },
}
