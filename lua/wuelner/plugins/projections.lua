return {
  "gnikdroy/projections.nvim",
  config = function()
    require("projections").setup({
      workspaces = { { "~/Workspace", {} } },
      patterns = { ".git" },
      store_hooks = {
        pre = function()
          vim.api.nvim_command("FernDo close")
        end,
      },
    })
  end,
}
