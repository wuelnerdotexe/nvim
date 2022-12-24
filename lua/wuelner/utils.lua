local M = {}

M.aerial_breadcrumbs = function()
  local symbols = require("aerial").get_location(true)
  local depth = nil or #symbols
  local table_unpack = table.unpack

  symbols = depth > 0 and { table_unpack(symbols, 1, depth) } or { table_unpack(symbols, #symbols + 1 + depth) }

  local parts = {}

  for _, symbol in ipairs(symbols) do
    table.insert(parts, symbol.icon .. " " .. symbol.name)
  end

  local breadcrumbs = table.concat(parts, " > ")

  return breadcrumbs == "" and "" or breadcrumbs
end

M.lsp_format = function(bufnr)
  vim.lsp.buf.format({
    bufnr = bufnr,
    filter = function(client)
      return client.name == "null-ls"
    end,
  })
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

  local null_ls = client.name == "null-ls" and true or false
  local lsp_format = function()
    require("wuelner.utils").lsp_format(bufnr)
  end

  if null_ls and supports_method("textDocument/formatting") then
    client.server_capabilities.documentFormattingProvider = true

    vim.api.nvim_buf_create_user_command(bufnr, "PrettierFormatAll", lsp_format, {})
  elseif null_ls and supports_method("textDocument/rangeFormatting") then
    client.server_capabilities.documentRangeFormattingProvider = true

    keymap_set("x", "<leader>f", lsp_format, keymap_opts)
  else
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end
end

return M
