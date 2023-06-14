return {
  "jackieaskins/cmp-emmet",
  build = "npm run release",
  dependencies = { "hrsh7th/nvim-cmp", "L3MON4D3/LuaSnip" },
  init = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "css,sass,scss,less,xml,html,javascriptreact,typescriptreact",
      group = vim.api.nvim_create_augroup("load_cmp_emmet", { clear = false }),
      callback = function(ev)
        if package.loaded["cmp-emmet"] then
          vim.api.nvim_clear_autocmds({ group = ev.group })

          return true
        end

        vim.api.nvim_create_autocmd("InsertEnter", {
          buffer = ev.buf,
          group = ev.group,
          callback = function()
            vim.api.nvim_clear_autocmds({ group = ev.group })

            require("lazy").load({ plugins = { "cmp-emmet" } })
          end,
        })
      end,
    })
  end,
}
