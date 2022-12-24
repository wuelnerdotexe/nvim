local config = function()
  require("lspconfig.ui.windows").default_options.border = "rounded"

  require("nvim-lightbulb").setup({ sign = { priority = 8 }, autocmd = { enabled = true } })
  vim.fn.sign_define("LightBulbSign", { text = "", texthl = "DiagnosticSignInfo", linehl = "", numhl = "" })

  local on_attach = require("wuelner.utils").lsp_on_attach
  local flags = { debounce_text_changes = 300 }
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

  require("mason-lspconfig").setup({
    ensure_installed = {
      "jsonls",
      "tsserver",
      "eslint",
      "cssls",
      "stylelint_lsp",
      "html",
      "tailwindcss",
    },
  })

  local provideFormatter = { provideFormatter = false }
  local validate = { validate = false }

  require("lspconfig").jsonls.setup({
    on_attach = on_attach,
    flags = flags,
    capabilities = capabilities,
    init_options = provideFormatter,
    settings = { json = { schemas = require("schemastore").json.schemas(), validate = { enable = true } } },
  })

  local server_setup = { on_attach = on_attach, flags = flags, capabilities = capabilities }

  require("lspconfig").tsserver.setup(server_setup)

  require("lspconfig").eslint.setup({ on_attach = on_attach, flags = flags, settings = { format = false } })

  require("lspconfig").cssls.setup({
    on_attach = on_attach,
    flags = flags,
    capabilities = capabilities,
    settings = { css = validate, less = validate, scss = validate },
  })

  require("lspconfig").stylelint_lsp.setup({ on_attach = on_attach, flags = flags })

  require("lspconfig").html.setup({
    on_attach = on_attach,
    flags = flags,
    capabilities = capabilities,
    init_options = provideFormatter,
  })

  require("lspconfig").tailwindcss.setup(server_setup)
end

return config
