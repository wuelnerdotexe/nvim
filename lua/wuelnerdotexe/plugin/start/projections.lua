return {
  "gnikdroy/projections.nvim",
  lazy = true,
  init = function()
    require("wuelnerdotexe.plugin.util").set_option(
      "sessionoptions",
      "blank,buffers,help,localoptions,winpos,winsize,folds,tabpages,curdir,terminal"
    )

    vim.api.nvim_create_autocmd("VimEnter", {
      once = true,
      callback = function()
        if not require("wuelnerdotexe.plugin.util").enter_with_args() then
          vim.schedule(function() require("projections.switcher").switch(vim.loop.cwd()) end)
        end
      end,
    })

    vim.api.nvim_create_autocmd("VimLeavePre", {
      callback = function() require("projections.session").store(vim.loop.cwd()) end,
    })
  end,
  config = function()
    require("projections").setup({
      workspaces = { { "~/Developer", { ".git" } }, { "~/Developer/workspace/code", { ".git", "package.json" } } },
      patterns = { ".git", "package.json" },
      store_hooks = {
        pre = function()
          if package.loaded["neo-tree"] then vim.api.nvim_command("Neotree close") end
        end,
      },
    })
  end,
}
