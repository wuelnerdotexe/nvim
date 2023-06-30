return {
  "gnikdroy/projections.nvim",
  keys = {
    {
      "<leader>pf",
      function()
        if pcall(require, "telescope") then
          require("telescope").extensions.projections.projections()

          return
        end

        vim.notify("projections: cannot open telescope", vim.log.levels.ERROR)
      end,
      desc = "General: [f]ind the workspace [p]rojects",
    },
  },
  lazy = true,
  init = function()
    require("wuelnerdotexe.plugin.util").set_option(
      "sessionoptions",
      "blank,buffers,help,localoptions,winpos,winsize,folds,tabpages,curdir,terminal"
    )

    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        if
          require("wuelnerdotexe.plugin.util").enter_with_arguments()
          or require("projections.session").info(vim.loop.cwd()) == nil
        then
          return
        end

        vim.schedule(function() require("projections.session").restore(vim.loop.cwd()) end)
      end,
      once = true,
    })

    vim.api.nvim_create_autocmd("VimLeavePre", {
      callback = function(ev)
        if
          vim.tbl_contains({
            "git",
            "gitcommit",
            "gitrebase",
          }, vim.api.nvim_get_option_value("filetype", { buf = ev.buf }))
        then
          return
        end

        require("projections.session").store(vim.loop.cwd())
      end,
    })
  end,
  config = function()
    require("projections").setup({
      workspaces = { { "~/Developer", { ".git" } }, { "~/Developer/workspace/code", { ".git", "package.json" } } },
      patterns = { ".git", "package.json" },
      store_hooks = {
        pre = function()
          if package.loaded["neo-tree"] then require("neo-tree.command").execute({ action = "close" }) end
          if package.loaded["spectre"] then require("spectre").close() end
          if package.loaded["edgy"] then require("edgy").close() end
        end,
      },
    })
  end,
}
