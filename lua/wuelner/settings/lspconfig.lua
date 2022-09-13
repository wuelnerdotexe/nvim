local M = {}

M.config = function()
  require('mason-lspconfig').setup({ automatic_installation = true })

  local capabilities = require('cmp_nvim_lsp').update_capabilities(
    vim.lsp.protocol.make_client_capabilities()
  )

  capabilities.textDocument.completion.completionItem.snippetSupport = true

  local lsp_flags = { debounce_text_changes = 150 }

  local on_attach = function(client, bufnr)
    local clientname = client.name
    local lspbuf = vim.lsp.buf
    local diagnostic = vim.diagnostic
    local keymap = vim.keymap

    if vim.version().minor > 7 then
      local clientcapabilities = client.server_capabilities

      clientcapabilities.documentFormattingProvider = false
      clientcapabilities.documentRangeFormattingProvider = false
    else
      local clientcapabilities = client.resolved_capabilities

      clientcapabilities.document_formatting = false
      clientcapabilities.document_range_formatting = false
    end

    -- keymaps.
    local bufopts = { noremap = true, silent = true, buffer = bufnr }

    if clientname == 'tsserver' then
      keymap.set('n', '<space>e', diagnostic.open_float, bufopts)
      keymap.set('n', '[d', diagnostic.goto_prev, bufopts)
      keymap.set('n', ']d', diagnostic.goto_next, bufopts)
      keymap.set('n', '<space>q', diagnostic.setloclist, bufopts)
      keymap.set('n', 'gD', lspbuf.declaration, bufopts)
      keymap.set('n', 'gd', lspbuf.definition, bufopts)
      keymap.set('n', 'K', lspbuf.hover, bufopts)
      keymap.set('n', 'gi', lspbuf.implementation, bufopts)
      keymap.set('n', '<C-k>', lspbuf.signature_help, bufopts)
      keymap.set('n', '<space>D', lspbuf.type_definition, bufopts)
      keymap.set('n', '<space>rn', lspbuf.rename, bufopts)
      keymap.set('n', '<space>ca', lspbuf.code_action, bufopts)
      keymap.set('n', 'gr', lspbuf.references, bufopts)
    elseif clientname == 'cssls'  or clientname == 'html' then
      keymap.set('n', '<space>e', diagnostic.open_float, bufopts)
      keymap.set('n', '[d', diagnostic.goto_prev, bufopts)
      keymap.set('n', ']d', diagnostic.goto_next, bufopts)
      keymap.set('n', '<space>q', diagnostic.setloclist, bufopts)
      keymap.set('n', 'K', lspbuf.hover, bufopts)
    end
  end

  local border = {
    { '┌', 'FloatBorder' },
    { '─', 'FloatBorder' },
    { '┐', 'FloatBorder' },
    { '│', 'FloatBorder' },
    { '┘', 'FloatBorder' },
    { '─', 'FloatBorder' },
    { '└', 'FloatBorder' },
    { '│', 'FloatBorder' }
  }
  local lsp = vim.lsp
  local lsphandlers = lsp.handlers
  local handlers =  {
    ['textDocument/hover'] = lsp.with(lsphandlers.hover, {
      border = border
    }),
    ['textDocument/signatureHelp'] = lsp.with(lsphandlers.signature_help, {
      border = border
    }),
  }

  local lspconfig = require('lspconfig')

  lspconfig['jsonls'].setup({
    on_attach = on_attach,
    flags = lsp_flags,
    init_options = { provideFormatter = false }
  })

  lspconfig['tsserver'].setup({
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
    handlers = handlers
  })

  lspconfig['cssls'].setup({
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
    handlers = handlers
  })

  lspconfig['html'].setup({
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
    handlers = handlers,
    init_options = { provideFormatter = false }
  })

  lspconfig['tailwindcss'].setup({
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities
  })
end

return M

