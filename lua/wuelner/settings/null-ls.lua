local M = {}

M.config = function()
  require("null-ls").setup({
    update_in_insert = true,
    debounce = 300,
    on_attach = require("wuelner.utils").lsp_on_attach,
    sources = {
      require("null-ls").builtins.diagnostics.jsonlint,
      require("null-ls").builtins.diagnostics.markdownlint,
      require("null-ls").builtins.formatting.prettierd.with({
        condition = function(utils)
          return utils.root_has_file({
            ".prettierrc",
            ".prettierrc.json",
            ".prettierrc.yaml",
            ".prettierrc.yml",
            ".prettierrc.json5",
            ".prettierrc.js",
            ".prettierrc.cjs",
            "prettier.config.js",
            "prettier.config.cjs",
            ".prettierrc.toml",
          })
        end,
      }),
    },
  })
end

return M
