local lsp_diagnostics_configured

return {
  setup_lsp_diagnostics = function()
    if lsp_diagnostics_configured then return end

    local border = require("wuelnerdotexe.plugin.config").border and "rounded" or "none"

    vim.diagnostic.config({
      signs = { priority = 6 },
      float = { header = { "Diagnostics", "Title" }, border = border },
      update_in_insert = true,
      severity_sort = true,
    })

    local ref_floating_preview = vim.lsp.util.open_floating_preview

    vim.lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
      opts = opts or {}
      opts.border = border

      return ref_floating_preview(contents, syntax, opts, ...)
    end

    vim.api.nvim_set_keymap("n", "]d", "", { callback = function() vim.diagnostic.goto_next() end })
    vim.api.nvim_set_keymap("n", "[d", "", { callback = function() vim.diagnostic.goto_prev() end })
    vim.api.nvim_set_keymap("n", "<leader>dp", "", { callback = function() vim.diagnostic.open_float() end })
    vim.api.nvim_set_keymap("n", "<leader>dl", "", { callback = function() vim.diagnostic.setloclist() end })

    lsp_diagnostics_configured = true
  end,
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/completion") then
      vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = bufnr })
    end

    if client.supports_method("textDocument/rename") then
      vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>sr", "", { callback = function() vim.lsp.buf.rename() end })
    end

    if client.supports_method("textDocument/hover") then
      vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "", { callback = function() vim.lsp.buf.hover() end })
    end

    if client.supports_method("textDocument/signatureHelp") then
      vim.api.nvim_buf_set_keymap(bufnr, "i", "<C-k>", "", { callback = function() vim.lsp.buf.signature_help() end })
    end

    if client.supports_method("textDocument/references") then
      vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rl", "", { callback = function() vim.lsp.buf.references() end })
    end

    if client.supports_method("textDocument/definition") then
      vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "", { callback = function() vim.lsp.buf.definition() end })
    end

    if client.supports_method("textDocument/implementation") then
      vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "", { callback = function() vim.lsp.buf.implementation() end })
    end

    if client.supports_method("textDocument/codeAction") then
      vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "", { callback = function() vim.lsp.buf.code_action() end })
    end

    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>cf", "", {
        callback = function() vim.lsp.buf.format({ bufnr = bufnr }) end,
      })
    end

    if client.supports_method("textDocument/rangeFormatting") then
      vim.api.nvim_buf_set_keymap(bufnr, "x", "<leader>cf", "", {
        callback = function() vim.lsp.buf.format({ bufnr = bufnr }) end,
      })
    end
  end,
}
