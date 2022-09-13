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
      local loadedgitsigns = package.loaded.gitsigns
      local wo = vim.wo
      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      map('n', ']c', function()
        if wo.diff then return ']c' end
        vim.schedule(function() loadedgitsigns.next_hunk() end)
        return '<Ignore>'
      end, {expr=true})

      map('n', '[c', function()
        if wo.diff then return '[c' end
        vim.schedule(function() loadedgitsigns.prev_hunk() end)
        return '<Ignore>'
      end, {expr=true})

      map({'n', 'v'}, '<leader>hs', ':loadedgitsigns stage_hunk<CR>')
      map({'n', 'v'}, '<leader>hr', ':loadedgitsigns reset_hunk<CR>')
      map('n', '<leader>hu', loadedgitsigns.undo_stage_hunk)
      map('n', '<leader>hp', loadedgitsigns.preview_hunk)
      map('n', '<leader>hb', function()
        loadedgitsigns.blame_line{ full = true }
      end)
      map('n', '<leader>td', loadedgitsigns.toggle_deleted)
    end
  })
end

return M

