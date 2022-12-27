local config = function()
  require("null-ls").setup({
    border = "rounded",
    update_in_insert = true,
    debounce = 300,
    on_attach = require("wuelner.utils").lsp_on_attach,
    sources = {
      require("null-ls").builtins.diagnostics.jsonlint,
      require("null-ls").builtins.diagnostics.markdownlint,
      require("null-ls").builtins.formatting.prettierd.with({
        condition = function(utils)
          local call_function = vim.api.nvim_call_function
          local startpath = call_function("getcwd", {})
          local project_root = require("lspconfig.util").find_git_ancestor(startpath)
            or require("lspconfig.util").find_package_json_ancestor(startpath)

          if not project_root then
            return false
          end

          local config_files = {
            ".prettierrc",
            ".prettierrc.json",
            ".prettierrc.yml",
            ".prettierrc.yaml",
            ".prettierrc.json5",
            ".prettierrc.js",
            ".prettierrc.cjs",
            ".prettierrc.toml",
            "prettier.config.js",
            "prettier.config.cjs",
          }

          local exists = utils.has_file(config_files) or utils.root_has_file(config_files)

          if not exists then
            local ok, has_prettier_key = pcall(function()
              local package_json =
                vim.json.decode(table.concat(call_function("readfile", { project_root .. "/package.json" })))

              return not not package_json["prettier"]
            end)

            exists = ok and has_prettier_key
          end

          return exists
        end,
      }),
    },
  })

  require("mason-null-ls").setup({
    ensure_installed = { "jsonlint", "markdownlint", "prettierd" },
  })
end

return config
