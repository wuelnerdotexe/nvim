local M = {}

M.config = function()
  local null_ls = require('null-ls')
  local null_ls_builtins = null_ls.builtins

  null_ls.setup({
    diagnostic_config = { severity_sort = true },
    on_attach = function(client, bufnr)
      local vim_diagnostic = vim.diagnostic
      local keymap_set = vim.keymap.set
      local lsp_buf = vim.lsp.buf

      keymap_set(
        'n', '<leader>dl',
        vim_diagnostic.setloclist,
        { noremap = true, silent = true, buffer = bufnr }
      )

      keymap_set(
        'n', '[d',
        vim_diagnostic.goto_prev,
        { noremap = true, silent = true, buffer = bufnr }
      )

      keymap_set(
        'n', ']d',
        vim_diagnostic.goto_next,
        { noremap = true, silent = true, buffer = bufnr }
      )

      keymap_set(
        'n', '<leader>dp',
        vim_diagnostic.open_float,
        { noremap = true, silent = true, buffer = bufnr }
      )

      keymap_set(
        'n', '<leader>ca',
        lsp_buf.code_action,
        { noremap = true, silent = true, buffer = bufnr }
      )

      local vim_api = vim.api
      local augroup = vim_api.nvim_create_augroup('LspFormatting', {})

      if client.supports_method('textDocument/formatting')
      then
        vim_api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim_api.nvim_create_autocmd('BufWritePre', {
          group = augroup,
          buffer = bufnr,
          callback = function()
            if vim.version().minor < 8
            then
              lsp_buf.formatting_sync()
            else
              lsp_buf.format({ bufnr = bufnr })
            end
          end
        })
      end
    end,
    sources = {
      null_ls_builtins.diagnostics.eslint_d,
      null_ls_builtins.code_actions.eslint_d,
      null_ls_builtins.formatting.prettierd.with({
        condition = function(utils)
          return utils.root_has_file({
            '.prettierrc',
            '.prettierrc.json',
            '.prettierrc.yaml',
            '.prettierrc.yml',
            '.prettierrc.json5',
            '.prettierrc.js',
            '.prettierrc.cjs',
            'prettier.config.js',
            'prettier.config.cjs',
            '.prettierrc.toml',
          })
        end
      })
    },
    update_in_insert = true
  })
end

return M

