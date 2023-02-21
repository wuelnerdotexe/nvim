local on_attach = function(client, bufnr)
  if client.supports_method("textDocument/completion") then
    vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = bufnr })
  end

  if client.supports_method("textDocument/publishDiagnostics") then
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>dp", "", { callback = function() vim.diagnostic.open_float() end })
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>dl", "", { callback = function() vim.diagnostic.setloclist() end })

    local goto_next_repeatable, goto_prev_repeatable =
      require("nvim-treesitter.textobjects.repeatable_move").make_repeatable_move_pair(
        vim.diagnostic.goto_next,
        vim.diagnostic.goto_prev
      )

    vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", "", { callback = goto_next_repeatable })
    vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", "", { callback = goto_prev_repeatable })
  end

  if client.supports_method("textDocument/hover") then
    vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "", { callback = function() vim.lsp.buf.hover() end })
  end

  if client.supports_method("textDocument/signatureHelp") then
    vim.api.nvim_buf_set_keymap(bufnr, "i", "<C-k>", "", { callback = function() vim.lsp.buf.signature_help() end })
  end

  if client.supports_method("textDocument/rename") then
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>sr", "", { callback = function() vim.lsp.buf.rename() end })
  end

  if client.supports_method("textDocument/references") then
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rl", "", { callback = function() vim.lsp.buf.references() end })
  end

  if client.supports_method("textDocument/definition") then
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "", { callback = function() vim.lsp.buf.definition() end })
  end

  if client.supports_method("textDocument/implementation") then
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "", { callback = function() vim.lsp.buf.implementation() end })
  end

  if client.supports_method("textDocument/codeAction") then
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "", { callback = function() vim.lsp.buf.code_action() end })
  end

  if client.supports_method("textDocument/formatting") then
    client.server_capabilities.documentFormattingProvider = true
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>cf", "", {
      callback = function() vim.lsp.buf.format({ bufnr = bufnr }) end,
    })
  end

  if client.supports_method("textDocument/rangeFormatting") then
    client.server_capabilities.documentRangeFormattingProvider = true
    vim.api.nvim_buf_set_keymap(bufnr, "x", "<leader>cf", "", {
      callback = function() vim.lsp.buf.format({ bufnr = bufnr }) end,
    })
  end
end

local borderchars = require("wuelnerdotexe.plugin.util").get_border().chars

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
      vim.diagnostic.config({
        signs = { priority = require("wuelnerdotexe.plugin.config").signs_priority.diagnostic },
        virtual_text = false,
        virtual_lines = true,
        float = { header = { "Diagnostics", "Title" }, border = borderchars },
        update_in_insert = true,
        severity_sort = true,
      })

      local ref_floating_preview = vim.lsp.util.open_floating_preview

      vim.lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
        opts = opts or require("wuelnerdotexe.plugin.util").empty_table
        opts.border = borderchars

        return ref_floating_preview(contents, syntax, opts, ...)
      end

      require("lspconfig.ui.windows").default_options.border = borderchars

      local flags = { debounce_text_changes = 284 }
      local capabilities = vim.lsp.protocol.make_client_capabilities()

      capabilities.textDocument.foldingRange = { dynamicRegistration = false, lineFoldingOnly = true }
      capabilities.textDocument.completion.completionItem.snippetSupport = true
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

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
        border = borderchars,
        update_in_insert = true,
        debounce = 284,
        on_attach = on_attach,
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
    event = require("wuelnerdotexe.plugin.config").open_file_event,
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
    event = require("wuelnerdotexe.plugin.config").open_file_event,
    config = function()
      require("lsp_lines").setup()

      vim.api.nvim_set_keymap("n", "<leader>lt", "", { callback = function() require("lsp_lines").toggle() end })
    end,
  },
}
