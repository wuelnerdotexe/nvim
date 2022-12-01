local M = {}

M.config = function()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

  local on_attach = require("wuelner.utils").lsp_on_attach
  local flags = { debounce_text_changes = 300 }

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

  vim.api.nvim_create_augroup("EslintFixAll", {})
  require("lspconfig").eslint.setup({
    on_attach = on_attach,
    flags = flags,
    settings = { format = false },
  })

  require("lspconfig").cssls.setup({
    on_attach = on_attach,
    flags = flags,
    capabilities = capabilities,
    settings = {
      css = { validate = false },
      less = { validate = false },
      scss = { validate = false },
    },
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

  require("lspconfig.ui.windows").default_options.border = "rounded"

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
