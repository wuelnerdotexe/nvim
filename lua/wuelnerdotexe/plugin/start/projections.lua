return {
  "gnikdroy/projections.nvim",
  lazy = true,
  keys = {
    {
      "<leader>pf",
      function()
        local telescope_status, telescope = pcall(require, "telescope")

        if telescope_status then
          if not package.loaded["telescope._extensions.projections"] then telescope.load_extension("projections") end

          telescope.extensions.projections.projections()
        else
          vim.notify("projections: cannot open telescope", vim.log.levels.ERROR)
        end
      end,
      desc = "General: [f]ind the workspace [p]rojects",
    },
  },
  init = function()
    require("wuelnerdotexe.plugin.util").set_option(
      "sessionoptions",
      "blank,buffers,help,localoptions,winpos,winsize,folds,tabpages,curdir,terminal"
    )

    vim.api.nvim_create_autocmd("VimEnter", {
      once = true,
      callback = function()
        if require("wuelnerdotexe.plugin.util").enter_with_args() then return end

        local cwd = vim.loop.cwd()

        if require("projections.session").info(cwd) ~= nil then
          vim.schedule(function() require("projections.session").restore(cwd) end)
        end
      end,
    })

    vim.api.nvim_create_autocmd("VimLeavePre", {
      callback = function(ev)
        if
          not vim.tbl_contains({
            "gitcommit",
            "gitrebase",
          }, vim.api.nvim_get_option_value("filetype", { buf = ev.buf }))
        then
          require("projections.session").store(vim.loop.cwd())
        end
      end,
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
