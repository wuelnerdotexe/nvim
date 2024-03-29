local lsp_diagnostics_configured

return {
  setup_lsp_diagnostics = function()
    if lsp_diagnostics_configured then return end

    lsp_diagnostics_configured = true

    vim.diagnostic.config({
      signs = { priority = 6 },
      virtual_text = { prefix = "▎" },
      float = { header = { "Diagnostics", "Title" }, border = "rounded" },
      update_in_insert = true,
      severity_sort = true,
    })

    local ref_floating_preview = vim.lsp.util.open_floating_preview

    vim.lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
      opts = opts or {}
      opts.border = "rounded"

      return ref_floating_preview(contents, syntax, opts, ...)
    end

    vim.api.nvim_set_keymap("n", "<leader>dp", "", {
      callback = function() vim.diagnostic.open_float() end,
      desc = "Language server: [p]review of the current [d]iagnostic",
    })

    vim.api.nvim_set_keymap("n", "<leader>dl", "", {
      callback = function() vim.diagnostic.setloclist() end,
      desc = "Language server: show [l]ist of [d]iagnostics",
    })

    vim.api.nvim_set_keymap("n", "]d", "", { callback = function() vim.diagnostic.goto_next() end })
    vim.api.nvim_set_keymap("n", "[d", "", { callback = function() vim.diagnostic.goto_prev() end })
  end,
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/signatureHelp") then
      vim.api.nvim_buf_set_keymap(bufnr, "i", "<C-k>", "", { callback = function() vim.lsp.buf.signature_help() end })
    end

    if client.supports_method("textDocument/definition") then
      vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "", { callback = function() vim.lsp.buf.definition() end })
    end

    if client.supports_method("textDocument/implementation") then
      vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "", { callback = function() vim.lsp.buf.implementation() end })
    end

    if client.supports_method("textDocument/references") then
      vim.api.nvim_buf_set_keymap(bufnr, "n", "<localleader>rl", "", {
        callback = function() vim.lsp.buf.references() end,
        desc = "Language server: show [l]ist of [r]eferences",
      })
    end

    if client.supports_method("textDocument/rename") then
      vim.api.nvim_buf_set_keymap(bufnr, "n", "<localleader>sr", "", {
        callback = function() vim.lsp.buf.rename() end,
        desc = "Language server: [r]ename the current [s]ymbol",
      })
    end

    if client.supports_method("textDocument/codeAction") then
      vim.api.nvim_buf_set_keymap(bufnr, "n", "<localleader>ca", "", {
        callback = function() vim.lsp.buf.code_action() end,
        desc = "Language server: show current [c]ode [a]ctions",
      })
    end

    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_buf_set_keymap(bufnr, "n", "<localleader>cf", "", {
        callback = function() vim.lsp.buf.format({ bufnr = bufnr }) end,
        desc = "Language server: [f]ormat the [c]ode",
      })
    end

    if client.supports_method("textDocument/rangeFormatting") then
      vim.api.nvim_buf_set_keymap(bufnr, "x", "<localleader>cf", "", {
        callback = function() vim.lsp.buf.format({ bufnr = bufnr }) end,
        desc = "Language server: [f]ormat the [c]ode",
      })
    end

    if client.supports_method("textDocument/inlayHint") then
      vim.api.nvim_buf_set_keymap(bufnr, "n", "<localleader>ht", "", {
        callback = function() vim.lsp.inlay_hint(bufnr, nil) end,
        desc = "Language server: [t]oggle inlay [h]ints",
      })
    end
  end,
}
