local M = {}

M.aerial_breadcrumbs = function()
  local ok, aerial = pcall(require, "aerial")

  if not ok then
    return "No symbols"
  end

  local symbols = aerial.get_location(true)
  local depth = nil or #symbols

  symbols = depth > 0 and { unpack(symbols, 1, depth) } or { unpack(symbols, #symbols + 1 + depth) }

  local parts = {}

  for _, symbol in ipairs(symbols) do
    table.insert(parts, "%#Aerial" .. symbol.kind .. "Icon#" .. symbol.icon .. " %*" .. symbol.name)
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
    vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = bufnr })
  end

  local buf_set_keymap = vim.api.nvim_buf_set_keymap

  if supports_method("textDocument/publishDiagnostics") then
    buf_set_keymap(bufnr, "n", "<leader>dp", "", {
      callback = function()
        vim.diagnostic.open_float()
      end,
    })

    buf_set_keymap(bufnr, "n", "<leader>dl", "", {
      callback = function()
        vim.diagnostic.setloclist()
      end,
    })

    buf_set_keymap(bufnr, "n", "[d", "", {
      callback = function()
        vim.diagnostic.goto_prev()
      end,
    })

    buf_set_keymap(bufnr, "n", "]d", "", {
      callback = function()
        vim.diagnostic.goto_next()
      end,
    })
  end

  if supports_method("textDocument/hover") then
    buf_set_keymap(bufnr, "n", "K", "", {
      callback = function()
        vim.lsp.buf.hover()
      end,
    })
  end

  if supports_method("textDocument/signatureHelp") then
    buf_set_keymap(bufnr, "i", "<C-k>", "", {
      callback = function()
        vim.lsp.buf.signature_help()
      end,
    })
  end

  if supports_method("textDocument/rename") then
    buf_set_keymap(bufnr, "n", "<leader>sr", "", {
      callback = function()
        vim.lsp.buf.rename()
      end,
    })
  end

  if supports_method("textDocument/references") then
    buf_set_keymap(bufnr, "n", "<leader>rl", "", {
      callback = function()
        vim.lsp.buf.references()
      end,
    })
  end

  if supports_method("textDocument/definition") then
    buf_set_keymap(bufnr, "n", "gd", "", {
      callback = function()
        vim.lsp.buf.definition()
      end,
    })
  end

  if supports_method("textDocument/implementation") then
    buf_set_keymap(bufnr, "n", "gi", "", {
      callback = function()
        vim.lsp.buf.implementation()
      end,
    })
  end

  if supports_method("textDocument/codeAction") then
    buf_set_keymap(bufnr, "n", "<leader>ca", "", {
      callback = function()
        vim.lsp.buf.code_action()
      end,
    })
  end

  local null_ls = client.name == "null-ls" and true or false
  local lsp_format = function()
    require("wuelner.utils").lsp_format(bufnr)
  end

  if null_ls and supports_method("textDocument/formatting") then
    client.server_capabilities.documentFormattingProvider = true

    vim.api.nvim_buf_create_user_command(bufnr, "PrettierFormatAll", function()
      lsp_format()
    end, {})
  elseif null_ls and supports_method("textDocument/rangeFormatting") then
    client.server_capabilities.documentRangeFormattingProvider = true

    buf_set_keymap(bufnr, "x", "<leader>f", "", {
      callback = function()
        lsp_format()
      end,
    })
  else
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end
end

return M
