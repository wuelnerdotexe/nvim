return {
  "gnikdroy/projections.nvim",
  lazy = false,
  config = function()
    require("projections").setup({
      workspaces = { { "~/Workspace", require("wuelnerdotexe.plugin.util").empty_table } },
      patterns = { ".git" },
      store_hooks = { pre = function() vim.api.nvim_command("FernDo close") end },
    })
  end,
}
