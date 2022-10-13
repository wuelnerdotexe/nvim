local M = {}

M.config = function()
  require("mason-lspconfig").setup({ automatic_installation = true })

  local signs = { Error = "●", Warn = "●", Info = "●", Hint = "●" }

  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type

    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end

  local vim_diagnostic = vim.diagnostic

  vim_diagnostic.config({
    virtual_text = { prefix = "▎" },
    float = {
      header = {
        "Diagnostics",
        "Title",
      },
      source = "always",
      border = "single",
    },
    update_in_insert = true,
    severity_sort = true,
  })

  local vim_lsp = vim.lsp
  local capabilities = require("cmp_nvim_lsp").update_capabilities(
    vim_lsp.protocol.make_client_capabilities()
  )

  local border = {
    { "┌", "FloatBorder" },
    { "─", "FloatBorder" },
    { "┐", "FloatBorder" },
    { "│", "FloatBorder" },
    { "┘", "FloatBorder" },
    { "─", "FloatBorder" },
    { "└", "FloatBorder" },
    { "│", "FloatBorder" },
  }

  local lsp_handlers = vim_lsp.handlers
  local lsp_with = vim_lsp.with
  local handlers = {
    ["textDocument/hover"] = lsp_with(lsp_handlers.hover, { border = border }),
    ["textDocument/signatureHelp"] = lsp_with(lsp_handlers.signature_help, {
      border = border,
    }),
  }

  local lspconfig = require("lspconfig")
  local lsp_flags = { debounce_text_changes = 300 }
  local on_attach = function(client, bufnr)
    require("aerial").on_attach(client, bufnr)

    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    local client_capabilities = client.server_capabilities

    client_capabilities.documentFormattingProvider = false
    client_capabilities.documentRangeFormattingProvider = false

    local client_name = client.name
    local keymap_set = vim.keymap.set
    local lsp_buf = vim.lsp.buf

    if client_name == "tsserver" then
      keymap_set("n", "K", lsp_buf.hover, { buffer = bufnr })
      keymap_set("n", "gd", lsp_buf.definition, { buffer = bufnr })
      keymap_set("n", "<leader>sr", lsp_buf.rename, { buffer = bufnr })
      keymap_set("n", "<leader>dl", vim_diagnostic.setloclist, {
        buffer = bufnr,
      })

      keymap_set("n", "[d", vim_diagnostic.goto_prev, { buffer = bufnr })
      keymap_set("n", "]d", vim_diagnostic.goto_next, { buffer = bufnr })
      keymap_set("n", "<leader>dp", vim_diagnostic.open_float, {
        buffer = bufnr,
      })

      keymap_set("n", "<leader>ca", lsp_buf.code_action, { buffer = bufnr })
    elseif client_name == "cssls" or client_name == "html" then
      keymap_set("n", "K", lsp_buf.hover, { buffer = bufnr })
      keymap_set("n", "<leader>dl", vim_diagnostic.setloclist, {
        buffer = bufnr,
      })

      keymap_set("n", "[d", vim_diagnostic.goto_prev, { buffer = bufnr })
      keymap_set("n", "]d", vim_diagnostic.goto_next, { buffer = bufnr })
      keymap_set("n", "<leader>dp", vim_diagnostic.open_float, {
        buffer = bufnr,
      })
    end
  end

  capabilities.textDocument.completion.completionItem.snippetSupport = true

  lspconfig["jsonls"].setup({
    on_attach = on_attach,
    flags = lsp_flags,
    init_options = { provideFormatter = false },
  })

  lspconfig["tsserver"].setup({
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
    handlers = handlers,
  })

  lspconfig["cssls"].setup({
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
    handlers = handlers,
  })

  lspconfig["html"].setup({
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
    handlers = handlers,
    init_options = { provideFormatter = false },
  })

  lspconfig["tailwindcss"].setup({
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
  })
end

return M
