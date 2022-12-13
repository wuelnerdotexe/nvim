local M = {}

M.aerial_breadcrumbs = function()
  local symbols = require("aerial").get_location(true)
  local depth = nil or #symbols
  local table_unpack = table.unpack

  symbols = depth > 0 and { table_unpack(symbols, 1, depth) }
    or { table_unpack(symbols, #symbols + 1 + depth) }

  local parts = {}

  for _, symbol in ipairs(symbols) do
    table.insert(parts, string.format("%s %s", symbol.icon, symbol.name))
  end

  local table_concat = table.concat

  return table_concat(parts, " > ") == "" and ""
    or table_concat(parts, " > ")
end

M.lsp_format = function(bufnr)
  vim.lsp.buf.format({
    bufnr = bufnr,
    filter = function(client)
      return client.name == "null-ls"
    end,
  })

  require("luasnip").session.current_nodes[bufnr] = nil
end

M.lsp_on_attach = function(client, bufnr)
  local supports_method = client.supports_method

  if supports_method("textDocument/completion") then
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  end

  local keymap_set = vim.keymap.set
  local keymap_opts = { buffer = bufnr }

  if supports_method("textDocument/publishDiagnostics") then
    keymap_set("n", "<leader>dp", vim.diagnostic.open_float, keymap_opts)
    keymap_set("n", "<leader>dl", vim.diagnostic.setloclist, keymap_opts)
    keymap_set("n", "[d", vim.diagnostic.goto_prev, keymap_opts)
    keymap_set("n", "]d", vim.diagnostic.goto_next, keymap_opts)
  end

  if supports_method("textDocument/hover") then
    keymap_set("n", "K", vim.lsp.buf.hover, keymap_opts)
  end

  if supports_method("textDocument/signatureHelp") then
    keymap_set("i", "<C-k>", vim.lsp.buf.signature_help, keymap_opts)
  end

  if supports_method("textDocument/rename") then
    keymap_set("n", "<leader>sr", vim.lsp.buf.rename, keymap_opts)
  end

  if supports_method("textDocument/references") then
    keymap_set("n", "<leader>rl", vim.lsp.buf.references, keymap_opts)
  end

  if supports_method("textDocument/definition") then
    keymap_set("n", "gd", vim.lsp.buf.definition, keymap_opts)
  end

  if supports_method("textDocument/implementation") then
    keymap_set("n", "gi", vim.lsp.buf.implementation, keymap_opts)
  end

  if supports_method("textDocument/codeAction") then
    keymap_set("n", "<leader>ca", vim.lsp.buf.code_action, keymap_opts)
  end

  local client_name = client.name
  local clear_autocmds = vim.api.nvim_clear_autocmds
  local create_autocmd = vim.api.nvim_create_autocmd

  if client_name == "eslint" then
    clear_autocmds({ group = "EslintFixAll", buffer = bufnr })
    create_autocmd("BufWritePre", {
      group = "EslintFixAll",
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end

  if supports_method("textDocument/formatting") then
    if client_name == "null-ls" then
      client.server_capabilities.documentFormattingProvider = true
      clear_autocmds({ group = "lsp_format", buffer = bufnr })
      create_autocmd("BufWritePre", {
        group = "lsp_format",
        buffer = bufnr,
        callback = function()
          require("wuelner.utils").lsp_format(bufnr)
        end,
      })
    else
      client.server_capabilities.documentFormattingProvider = false
    end
  end
end

return M
