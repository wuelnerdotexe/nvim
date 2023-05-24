return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufAdd", "BufReadPost", "BufNewFile" },
    dependencies = {
      "b0o/schemastore.nvim",
      {
        "williamboman/mason-lspconfig.nvim",
        dependencies = "williamboman/mason.nvim",
        config = function()
          require("mason-lspconfig").setup({
            ensure_installed = { "cssls", "eslint", "html", "jsonls", "tailwindcss", "tsserver", "yamlls" },
          })
        end,
      },
    },
    init = function() require("wuelnerdotexe.plugin.util").set_option("signcolumn", "yes:1") end,
    config = function()
      require("wuelnerdotexe.plugin.start.lsp.util").setup_lsp_diagnostics()

      require("lspconfig.ui.windows").default_options.border = require("wuelnerdotexe.plugin.config").border
          and "rounded"
        or "shadow"

      local basic_server_setup = {
        flags = { debounce_text_changes = 284 },
        on_attach = function(client, bufnr) require("wuelnerdotexe.plugin.start.lsp.util").on_attach(client, bufnr) end,
      }

      local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")

      if cmp_nvim_lsp_status then basic_server_setup.capabilities = cmp_nvim_lsp.default_capabilities() end

      require("lspconfig").jsonls.setup(vim.tbl_deep_extend("error", {
        settings = { json = { schemas = require("schemastore").json.schemas(), validate = { enable = true } } },
      }, basic_server_setup))

      require("lspconfig").yamlls.setup(vim.tbl_deep_extend("error", {
        settings = { yaml = { schemas = require("schemastore").yaml.schemas(), validate = { enable = true } } },
      }, basic_server_setup))

      require("lspconfig").html.setup(basic_server_setup)
      require("lspconfig").cssls.setup(basic_server_setup)
      require("lspconfig").tailwindcss.setup(basic_server_setup)
      require("lspconfig").tsserver.setup(basic_server_setup)
      require("lspconfig").eslint.setup(basic_server_setup)
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufAdd", "BufRead", "BufNewFile" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "jay-babu/mason-null-ls.nvim",
        dependencies = "williamboman/mason.nvim",
        config = function()
          require("mason-null-ls").setup({
            ensure_installed = { "actionlint", "jsonlint", "markdownlint", "prettierd", "yamllint" },
          })
        end,
      },
    },
    init = function() require("wuelnerdotexe.plugin.util").set_option("signcolumn", "yes:1") end,
    config = function()
      require("wuelnerdotexe.plugin.start.lsp.util").setup_lsp_diagnostics()

      require("null-ls").setup({
        border = require("wuelnerdotexe.plugin.config").border and "rounded" or "shadow",
        debounce = 284,
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
    event = "LspAttach",
    config = function()
      require("lsp_lines").setup()

      vim.diagnostic.config({ virtual_text = false, virtual_lines = false })

      vim.api.nvim_set_keymap("n", "<leader>lt", "", {
        callback = function() require("lsp_lines").toggle() end,
        desc = "Language server: [t]oggle [l]ines diagnostic",
      })
    end,
  },
}
