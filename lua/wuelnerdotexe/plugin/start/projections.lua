return {
  "gnikdroy/projections.nvim",
  lazy = true,
  init = function()
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        if not require("wuelnerdotexe.plugin.util").enter_with_args() then
          require("projections.switcher").switch(vim.loop.cwd())
        end

        return true
      end,
      once = true,
    })

    vim.api.nvim_create_autocmd("VimLeavePre", {
      callback = function()
        require("projections.session").store(vim.loop.cwd())

        return true
      end,
      once = true,
    })
  end,
  config = function()
    require("projections").setup({
      workspaces = { { "~/Workspace", TBL } },
      patterns = { ".git" },
      store_hooks = {
        pre = function()
          if package.loaded["neo-tree"] then vim.api.nvim_command("Neotree close") end
        end,
      },
    })
  end,
}
