local M = {}

M.config = function()
  require('gitsigns').setup({
    signs = {
      add = { hl = 'GitSignsAdd', text = '▋' },
      change = { hl = 'GitSignsChange', text = '▋' },
      delete = { hl = 'GitSignsDelete', text = '▁' },
      topdelete = { hl = 'GitSignsDelete', text = '▔' },
      changedelete = { hl = 'GitSignsChange', text = '▋' }
    },
    on_attach = function(bufnr)
      local loaded_gitsigns = package.loaded.gitsigns
      local map = function(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end
      local wo_diff = vim.wo.diff

      map('n', '[h', function()
        if wo_diff then return '[h' end
        vim.schedule(function() loaded_gitsigns.prev_hunk() end)
        return '<Ignore>'
      end, { expr = true })

      map('n', ']h', function()
        if wo_diff then return ']h' end
        vim.schedule(function() loaded_gitsigns.next_hunk() end)
        return '<Ignore>'
      end, { expr = true })

      map('n', '<leader>hp', loaded_gitsigns.preview_hunk)
      map({ 'n', 'v' }, '<leader>hr', '<Cmd>Gitsigns reset_hunk<CR>')
      map({ 'n', 'v' }, '<leader>hs', '<Cmd>Gitsigns stage_hunk<CR>')
      map('n', '<leader>hu', loaded_gitsigns.undo_stage_hunk)
    end
  })
end

return M

