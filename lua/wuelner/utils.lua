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

  return table_concat(parts, " > ") == "" and "..."
    or table_concat(parts, " > ")
end

M.lsp_on_attach = function(client, bufnr)
  local supports_method = client.supports_method

  if supports_method("textDocument/completion") then
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  end

  if supports_method("textDocument/formatting") then
    if client.name == "null-ls" then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr })
          require("luasnip").session.current_nodes[bufnr] = nil
        end,
      })
    else
      client.server_capabilities.documentFormattingProvider = false
    end
  end

  if supports_method("textDocument/rangeFormatting") then
    client.server_capabilities.documentRangeFormattingProvider = false
  end

  local keymap_set = vim.keymap.set

  if supports_method("textDocument/hover") then
    keymap_set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
  end

  if supports_method("textDocument/publishDiagnostics") then
    keymap_set("n", "<leader>dl", vim.diagnostic.setloclist, {
      buffer = bufnr,
    })
    keymap_set("n", "[d", vim.diagnostic.goto_prev, { buffer = bufnr })
    keymap_set("n", "]d", vim.diagnostic.goto_next, { buffer = bufnr })
    keymap_set("n", "<leader>dp", vim.diagnostic.open_float, {
      buffer = bufnr,
    })
  end

  if supports_method("textDocument/definition") then
    keymap_set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })
  end

  if supports_method("textDocument/rename") then
    keymap_set("n", "<leader>sr", vim.lsp.buf.rename, { buffer = bufnr })
  end

  if supports_method("textDocument/codeAction") then
    keymap_set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr })
  end
end

return M
