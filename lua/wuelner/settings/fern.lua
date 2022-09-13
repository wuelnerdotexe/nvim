local M = {}

M.setup = function()
  local g = vim.g

  g['fern#default_hidden'] = 1
  g['fern#default_exclude'] = [[^\%(\.git\|node_modules\)$]]
  g['fern#drawer_width'] = 33
  g['fern#renderer'] = 'nerdfont'
  g['fern#disable_default_keymaps'] = 1
end

M.config = function()
  local keymap = vim.keymap

  vim.api.nvim_create_autocmd('FileType', {
    pattern = 'fern',
    callback = function()
      vim.fn['glyph_palette#apply']()

      local opt_local = vim.opt_local

      opt_local.number = false
      opt_local.relativenumber = false

      vim.keymap.set('n', '<Plug>(fern-action-open:side)',
        function()
          return vim.fn['fern#smart#drawer'](
            '<Plug>(fern-action-open:rightest)',
            '<Plug>(fern-action-open:vsplit)',
            '<Cmd>echo "open:side disabled"<CR>'
          )
        end, { buffer = true, expr = true })

      local bufopts = { buffer = true, nowait = true }

      keymap.set('n', 'os', '<Plug>(fern-action-open:side)', bufopts)
      keymap.set('n', 'ot', '<Plug>(fern-action-open:tabedit)', bufopts)
      keymap.set('n', 'n', '<Plug>(fern-action-new-path)', bufopts)
      keymap.set('n', 'nd', '<Plug>(fern-action-new-dir)', bufopts)
      keymap.set('n', 'nf', '<Plug>(fern-action-new-file)', bufopts)
      keymap.set('n', 'c', '<Plug>(fern-action-copy)', bufopts)
      keymap.set('n', 'm', '<Plug>(fern-action-move)', bufopts)
      keymap.set('n', 'd', '<Plug>(fern-action-remove)', bufopts)
      keymap.set('n', 'V', '<Plug>(fern-action-mark:toggle)', bufopts)
      keymap.set('n', '<CR>', '<Plug>(fern-action-open-or-expand)', bufopts)
      keymap.set('n', '<BS>', '<Plug>(fern-action-collapse)', bufopts)
      keymap.set('n', '<F5>', '<Plug>(fern-action-reload)', bufopts)
      keymap.set('n', '<ESC>', '<Plug>(fern-action-mark:clear)', bufopts)
    end
  })

  local opts = { silent = true }

  keymap.set('n', '<leader>et', '<Cmd>Fern . -drawer -right -toggle<CR>', opts)
  keymap.set('n', '<leader>er', '<Cmd>Fern . -reveal=% -drawer -right -toggle<CR>', opts)
end

return M

