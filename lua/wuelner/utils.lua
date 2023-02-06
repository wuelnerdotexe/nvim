local M = {}

M.aerial_breadcrumbs = function()
  if not package.loaded["aerial"] then
    return "No symbols"
  end

  local symbols = require("aerial").get_location(true)
  local depth = nil or #symbols

  symbols = depth > 0 and { unpack(symbols, 1, depth) } or { unpack(symbols, #symbols + 1 + depth) }

  local parts = {}

  for _, symbol in ipairs(symbols) do
    table.insert(parts, "%#Aerial" .. symbol.kind .. "Icon#" .. symbol.icon .. " %*" .. symbol.name)
  end

  local breadcrumbs = table.concat(parts, " > ")

  return breadcrumbs == "" and "" or breadcrumbs
end

M.lsp_on_attach = function(client, bufnr)
  if client.supports_method("textDocument/completion") then
    vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = bufnr })
  end

  if client.supports_method("textDocument/publishDiagnostics") then
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>dp", "", {
      callback = function()
        vim.diagnostic.open_float()
      end,
    })

    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>dl", "", {
      callback = function()
        vim.diagnostic.setloclist()
      end,
    })

    vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", "", {
      callback = function()
        vim.diagnostic.goto_prev()
      end,
    })

    vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", "", {
      callback = function()
        vim.diagnostic.goto_next()
      end,
    })
  end

  if client.supports_method("textDocument/hover") then
    vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "", {
      callback = function()
        vim.lsp.buf.hover()
      end,
    })
  end

  if client.supports_method("textDocument/signatureHelp") then
    vim.api.nvim_buf_set_keymap(bufnr, "i", "<C-k>", "", {
      callback = function()
        vim.lsp.buf.signature_help()
      end,
    })
  end

  if client.supports_method("textDocument/rename") then
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>sr", "", {
      callback = function()
        vim.lsp.buf.rename()
      end,
    })
  end

  if client.supports_method("textDocument/references") then
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rl", "", {
      callback = function()
        vim.lsp.buf.references()
      end,
    })
  end

  if client.supports_method("textDocument/definition") then
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "", {
      callback = function()
        vim.lsp.buf.definition()
      end,
    })
  end

  if client.supports_method("textDocument/implementation") then
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "", {
      callback = function()
        vim.lsp.buf.implementation()
      end,
    })
  end

  if client.supports_method("textDocument/codeAction") then
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "", {
      callback = function()
        vim.lsp.buf.code_action()
      end,
    })
  end

  if client.supports_method("textDocument/formatting") then
    client.server_capabilities.documentFormattingProvider = true
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>cf", "", {
      callback = function()
        vim.lsp.buf.format({ bufnr = bufnr })
      end,
    })
  end

  if client.supports_method("textDocument/rangeFormatting") then
    client.server_capabilities.documentRangeFormattingProvider = true
    vim.api.nvim_buf_set_keymap(bufnr, "x", "<leader>cf", "", {
      callback = function()
        vim.lsp.buf.format({ bufnr = bufnr })
      end,
    })
  end
end

return M
