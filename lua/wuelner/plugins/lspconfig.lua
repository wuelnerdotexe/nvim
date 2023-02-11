return {
  "neovim/nvim-lspconfig",
  event = "BufReadPre",
  dependencies = {
    "b0o/schemastore.nvim",
    { "hrsh7th/cmp-nvim-lsp", dependencies = "hrsh7th/nvim-cmp" },
    {
      "williamboman/mason-lspconfig.nvim",
      dependencies = "williamboman/mason.nvim",
      config = function()
        require("mason-lspconfig").setup({
          ensure_installed = {
            "bashls",
            "cssls",
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
    require("lspconfig.ui.windows").default_options.border = "rounded"

    local flags = { debounce_text_changes = 300 }
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    capabilities.textDocument.foldingRange = { dynamicRegistration = false, lineFoldingOnly = true }
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    require("lspconfig").stylelint_lsp.setup({ on_attach = require("wuelner.utils").lsp_on_attach, flags = flags })
    require("lspconfig").eslint.setup({
      on_attach = require("wuelner.utils").lsp_on_attach,
      flags = flags,
      settings = { format = false },
    })

    require("lspconfig").html.setup({
      on_attach = require("wuelner.utils").lsp_on_attach,
      flags = flags,
      capabilities = capabilities,
      init_options = { provideFormatter = false },
    })

    require("lspconfig").jsonls.setup({
      on_attach = require("wuelner.utils").lsp_on_attach,
      flags = flags,
      capabilities = capabilities,
      init_options = { provideFormatter = false },
      settings = { json = { schemas = require("schemastore").json.schemas(), validate = { enable = true } } },
    })

    require("lspconfig").yamlls.setup({
      on_attach = require("wuelner.utils").lsp_on_attach,
      flags = flags,
      capabilities = capabilities,
      settings = { yaml = { schemas = require("schemastore").json.schemas() } },
    })

    local validate = { validate = false }

    require("lspconfig").cssls.setup({
      on_attach = require("wuelner.utils").lsp_on_attach,
      flags = flags,
      capabilities = capabilities,
      settings = { css = validate, less = validate, scss = validate },
    })

    local basic_setup =
      { on_attach = require("wuelner.utils").lsp_on_attach, flags = flags, capabilities = capabilities }

    require("lspconfig").bashls.setup(basic_setup)
    require("lspconfig").dockerls.setup(basic_setup)
    require("lspconfig").tsserver.setup(basic_setup)
    require("lspconfig").tailwindcss.setup(basic_setup)
  end,
}
