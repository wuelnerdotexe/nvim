return {
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
      "b0o/schemastore.nvim",
      { "hrsh7th/cmp-nvim-lsp", dependencies = { "hrsh7th/nvim-cmp", "L3MON4D3/LuaSnip" } },
      { "nvim-treesitter/nvim-treesitter-textobjects", dependencies = "nvim-treesitter/nvim-treesitter" },
      {
        "williamboman/mason-lspconfig.nvim",
        dependencies = "williamboman/mason.nvim",
        config = function()
          require("mason-lspconfig").setup({
            ensure_installed = {
              "bashls",
              "cssls",
              "docker_compose_language_service",
              "dockerls",
              "eslint",
              "html",
              "jsonls",
              "stylelint_lsp",
              "tailwindcss",
              "tsserver",
              "yamlls",
            },
          })
        end,
      },
    },
    config = function()
      local borderstyle = require("wuelnerdotexe.plugin.util").get_border().style

      vim.diagnostic.config({
        signs = { priority = require("wuelnerdotexe.plugin.config").signs_priority.diagnostic },
        virtual_text = false,
        virtual_lines = true,
        float = { header = { "Diagnostics", "Title" }, border = borderstyle },
        update_in_insert = true,
        severity_sort = true,
      })

      local ref_floating_preview = vim.lsp.util.open_floating_preview

      vim.lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
        opts = opts or TBL
        opts.border = borderstyle

        return ref_floating_preview(contents, syntax, opts, ...)
      end

      require("lspconfig.ui.windows").default_options.border = borderstyle

      local flags = { debounce_text_changes = 284 }
      local capabilities = vim.lsp.protocol.make_client_capabilities()

      capabilities.textDocument.foldingRange = { dynamicRegistration = false, lineFoldingOnly = true }
      capabilities.textDocument.completion.completionItem.snippetSupport = true
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

      local on_attach = function(client, bufnr) require("wuelnerdotexe.plugin.start.lsp.attach")(client, bufnr) end

      require("lspconfig").stylelint_lsp.setup({ on_attach = on_attach, flags = flags })
      require("lspconfig").eslint.setup({ on_attach = on_attach, flags = flags, settings = { format = false } })

      require("lspconfig").html.setup({
        on_attach = on_attach,
        flags = flags,
        capabilities = capabilities,
        init_options = { provideFormatter = false },
      })

      require("lspconfig").jsonls.setup({
        on_attach = on_attach,
        flags = flags,
        capabilities = capabilities,
        init_options = { provideFormatter = false },
        settings = { json = { schemas = require("schemastore").json.schemas(), validate = { enable = true } } },
      })

      require("lspconfig").yamlls.setup({
        on_attach = on_attach,
        flags = flags,
        capabilities = capabilities,
        settings = { yaml = { schemas = require("schemastore").json.schemas() } },
      })

      local validate = { validate = false }

      require("lspconfig").cssls.setup({
        on_attach = on_attach,
        flags = flags,
        capabilities = capabilities,
        settings = { css = validate, less = validate, scss = validate },
      })

      local basic_setup = { on_attach = on_attach, flags = flags, capabilities = capabilities }

      require("lspconfig").bashls.setup(basic_setup)
      require("lspconfig").dockerls.setup(basic_setup)
      require("lspconfig").docker_compose_language_service.setup(basic_setup)
      require("lspconfig").tsserver.setup(basic_setup)
      require("lspconfig").tailwindcss.setup(basic_setup)
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "BufReadPre",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig",
      { "nvim-treesitter/nvim-treesitter-textobjects", dependencies = "nvim-treesitter/nvim-treesitter" },
      {
        "jay-babu/mason-null-ls.nvim",
        dependencies = "williamboman/mason.nvim",
        config = function()
          require("mason-null-ls").setup({
            ensure_installed = {
              "actionlint",
              "hadolint",
              "jsonlint",
              "markdownlint",
              "prettierd",
              "shfmt",
              "yamllint",
            },
          })
        end,
      },
    },
    config = function()
      require("null-ls").setup({
        border = require("wuelnerdotexe.plugin.util").get_border().style,
        update_in_insert = true,
        debounce = 284,
        on_attach = function(client, bufnr) require("wuelnerdotexe.plugin.start.lsp.attach")(client, bufnr) end,
        sources = {
          require("null-ls").builtins.diagnostics.markdownlint,
          require("null-ls").builtins.diagnostics.hadolint,
          require("null-ls").builtins.diagnostics.jsonlint,
          require("null-ls").builtins.diagnostics.yamllint,
          require("null-ls").builtins.diagnostics.actionlint,
          require("null-ls").builtins.formatting.shfmt,
          require("null-ls").builtins.formatting.prettierd.with({
            condition = function(utils)
              local config_files = require("lspconfig.util").insert_package_json({
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
              }, "prettier")

              return utils.has_file(config_files) or utils.root_has_file(config_files)
            end,
          }),
        },
      })
    end,
  },
  {
    "kosayoda/nvim-lightbulb",
    event = "LspAttach",
    config = function()
      require("nvim-lightbulb").setup({
        sign = { priority = require("wuelnerdotexe.plugin.config").signs_priority.lightbulb },
        autocmd = { enabled = true },
      })

      vim.api.nvim_call_function(
        "sign_define",
        { "LightBulbSign", { text = "", texthl = "DiagnosticSignInfo", linehl = "", numhl = "" } }
      )
    end,
  },
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    event = "LspAttach",
    config = function()
      require("lsp_lines").setup()

      vim.api.nvim_set_keymap("n", "<leader>lt", "", { callback = function() require("lsp_lines").toggle() end })
    end,
  },
}
