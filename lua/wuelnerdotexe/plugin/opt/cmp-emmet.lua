return {
  "jackieaskins/cmp-emmet",
  build = "npm run release",
  dependencies = { "hrsh7th/nvim-cmp", "L3MON4D3/LuaSnip" },
  lazy = true,
  init = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "css,sass,scss,less,xml,html,javascriptreact,typescriptreact",
      callback = function(ev)
        vim.api.nvim_buf_set_keymap(ev.buf, "i", "<M-e>", "", {
          callback = function()
            if not package.loaded["cmp-emmet"] then require("lazy").load({ plugins = { "cmp-emmet" } }) end

            require("cmp").complete({ config = { sources = { { name = "emmet" } } } })
          end,
        })
      end,
    })
  end,
}
