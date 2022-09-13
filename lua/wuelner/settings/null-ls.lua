local M = {}

M.config = function()
  local null_ls = require('null-ls')

  null_ls.setup({
    on_attach = function(client, bufnr)
      local api = vim.api
      local diagnostic = vim.diagnostic
      local lspbuf = vim.lsp.buf
      local keymap = vim.keymap
      local bufopts = { noremap = true, silent = true, buffer = bufnr }

      keymap.set('n', '<space>e', diagnostic.open_float, bufopts)
      keymap.set('n', '[d', diagnostic.goto_prev, bufopts)
      keymap.set('n', ']d', diagnostic.goto_next, bufopts)
      keymap.set('n', '<space>q', diagnostic.setloclist, bufopts)
      keymap.set('n', '<space>ca', lspbuf.code_action, bufopts)

      local augroup = api.nvim_create_augroup('LspFormatting', {})

      if client.supports_method('textDocument/formatting') then
        api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        api.nvim_create_autocmd('BufWritePre', {
          group = augroup,
          buffer = bufnr,
          callback = function()
            if vim.version().minor > 7 then
              lspbuf.format({ bufnr = bufnr })
            else
              lspbuf.formatting_sync()
            end
          end
        })
      end
    end,
    sources = {
      null_ls.builtins.diagnostics.eslint_d,
      null_ls.builtins.code_actions.eslint_d,
      null_ls.builtins.formatting.prettierd.with({
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
    update_in_insert = false
  })
end

return M

