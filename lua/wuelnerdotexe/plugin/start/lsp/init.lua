return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "b0o/schemastore.nvim",
      {
        "williamboman/mason-lspconfig.nvim",
        dependencies = "williamboman/mason.nvim",
        cmd = { "LspInstall", "LspUninstall" },
        config = function()
          require("mason-lspconfig").setup({
            ensure_installed = { "cssls", "eslint", "html", "jsonls", "tailwindcss", "tsserver", "yamlls" },
          })
        end,
      },
    },
    cmd = { "LspInfo", "LspLog", "LspRestart", "LspStart", "LspStop" },
    event = { "BufReadPost", "FileType" },
    init = function()
      require("wuelnerdotexe.plugin.util").add_colorscheme_integration("lspconfig")

      require("wuelnerdotexe.plugin.util").set_option("signcolumn", "yes:1")

      require("wuelnerdotexe.plugin.start.lsp.util").setup_lsp_diagnostics()

      table.insert(require("wuelnerdotexe.plugin.util").user_interface_filetypes, "lspinfo")
    end,
    config = function()
      require("lspconfig.ui.windows").default_options.border = "rounded"

      local basic_config = {
        flags = { debounce_text_changes = vim.api.nvim_get_option_value("updatetime", { scope = "global" }) },
        capabilities = pcall(require, "cmp_nvim_lsp") and require("cmp_nvim_lsp").default_capabilities() or {},
        on_attach = function(client, bufnr) require("wuelnerdotexe.plugin.start.lsp.util").on_attach(client, bufnr) end,
      }

      basic_config.capabilities.textDocument.foldingRange = { dynamicRegistration = false, lineFoldingOnly = true }

      require("lspconfig").jsonls.setup(vim.tbl_deep_extend("error", {
        settings = { json = { schemas = require("schemastore").json.schemas(), validate = { enable = true } } },
      }, basic_config))

      require("lspconfig").yamlls.setup(vim.tbl_deep_extend("error", {
        settings = { yaml = { schemas = require("schemastore").yaml.schemas(), validate = { enable = true } } },
      }, basic_config))

      require("lspconfig").html.setup(vim.tbl_deep_extend("error", {}, basic_config))
      require("lspconfig").cssls.setup(vim.tbl_deep_extend("error", {}, basic_config))
      require("lspconfig").tailwindcss.setup(vim.tbl_deep_extend("error", {}, basic_config))

      require("lspconfig").tsserver.setup(vim.tbl_deep_extend("error", {
        settings = {
          javascript = {
            inlayHints = {
              includeInlayEnumMemberValueHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = true,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayVariableTypeHintsWhenTypeMatchesName = true,
            },
          },
          typescript = {
            inlayHints = {
              includeInlayEnumMemberValueHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = true,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayVariableTypeHintsWhenTypeMatchesName = true,
            },
          },
        },
      }, basic_config))

      require("lspconfig").eslint.setup(vim.tbl_deep_extend("error", {}, basic_config))
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "jay-babu/mason-null-ls.nvim",
        dependencies = "williamboman/mason.nvim",
        cmd = { "NullLsInstall", "NullLsUninstall" },
        config = function()
          require("mason-null-ls").setup({
            ensure_installed = { "actionlint", "jsonlint", "markdownlint", "prettierd", "yamllint" },
          })
        end,
      },
    },
    cmd = { "NullLsInfo", "NullLsLog" },
    event = { "BufRead", "FileType" },
    init = function()
      require("wuelnerdotexe.plugin.util").add_colorscheme_integration("null-ls")

      require("wuelnerdotexe.plugin.util").set_option("signcolumn", "yes:1")

      require("wuelnerdotexe.plugin.start.lsp.util").setup_lsp_diagnostics()

      table.insert(require("wuelnerdotexe.plugin.util").user_interface_filetypes, "null-ls-info")
    end,
    config = function()
      require("null-ls").setup({
        border = "rounded",
        debounce = vim.api.nvim_get_option_value("updatetime", { scope = "global" }),
        diagnostic_config = { severity_sort = true },
        on_attach = function(client, bufnr) require("wuelnerdotexe.plugin.start.lsp.util").on_attach(client, bufnr) end,
        sources = {
          require("null-ls").builtins.diagnostics.jsonlint,
          require("null-ls").builtins.diagnostics.yamllint,
          require("null-ls").builtins.diagnostics.actionlint,
          require("null-ls").builtins.diagnostics.markdownlint,
          require("null-ls").builtins.formatting.prettierd,
        },
        update_in_insert = true,
      })
    end,
  },
  {
    "VidocqH/lsp-lens.nvim",
    cmd = { "LspLensOff", "LspLensOn", "LspLensToggle" },
    event = "LspAttach",
    init = function() require("wuelnerdotexe.plugin.util").add_colorscheme_integration("lsp-lens") end,
    config = function()
      require("lsp-lens").setup({ ignore_filetype = require("wuelnerdotexe.plugin.util").user_interface_filetypes })
    end,
  },
  {
    "kosayoda/nvim-lightbulb",
    event = "LspAttach",
    init = function() require("wuelnerdotexe.plugin.util").set_option("signcolumn", "yes:1") end,
    config = function()
      require("nvim-lightbulb").setup({ autocmd = { enabled = true }, sign = { priority = 2 } })

      vim.api.nvim_call_function(
        "sign_define",
        { "LightBulbSign", { text = "", texthl = "DiagnosticSignInfo", linehl = "", numhl = "" } }
      )
    end,
  },
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    keys = {
      {
        "<leader>lt",
        function() require("lsp_lines").toggle() end,
        desc = "Language server: [t]oggle [l]ines diagnostic",
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("UIEnter", {
        callback = function() vim.diagnostic.config({ virtual_text = false, virtual_lines = false }) end,
      })
    end,
    config = function() require("lsp_lines").setup() end,
  },
}
