local M = {}

M.config = function()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

  local on_attach = require("wuelner.utils").lsp_on_attach
  local flags = { debounce_text_changes = 300 }

  require("lspconfig").jsonls.setup({
    on_attach = on_attach,
    flags = flags,
    capabilities = capabilities,
    init_options = { provideFormatter = false },
    settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
        validate = { enable = true },
      },
    },
  })

  require("lspconfig").tsserver.setup({
    on_attach = on_attach,
    flags = flags,
    capabilities = capabilities,
  })

  require("lspconfig").eslint.setup({
    on_attach = on_attach,
    flags = flags,
    settings = { format = false },
  })

  require("lspconfig").cssls.setup({
    on_attach = on_attach,
    flags = flags,
    capabilities = capabilities,
  })

  require("lspconfig").stylelint_lsp.setup({
    on_attach = on_attach,
    flags = flags,
  })

  require("lspconfig").html.setup({
    on_attach = on_attach,
    flags = flags,
    capabilities = capabilities,
    init_options = { provideFormatter = false },
  })

  require("lspconfig").tailwindcss.setup({
    on_attach = on_attach,
    flags = flags,
    capabilities = capabilities,
  })

  require("nvim-lightbulb").setup({
    sign = { priority = 8 },
    autocmd = { enabled = true },
  })

  vim.fn.sign_define(
    "LightBulbSign",
    { text = "", texthl = "DiagnosticSignInfo", linehl = "", numhl = "" }
  )
end

return M
