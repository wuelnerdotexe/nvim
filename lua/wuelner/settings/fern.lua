local M = {}

M.setup = function()
  local vim_g = vim.g

  vim_g['fern#default_hidden'] = 1
  vim_g['fern#default_exclude'] = [[^\%(]] ..
    [[\.git\|\.svn\|\.hg\|\CVS\|\.DS_Store\|\Thumbs.db\]] ..
  [[)$]]
  vim_g['fern#drawer_width'] = 33
  vim_g['fern#renderer'] = 'nerdfont'
  vim_g['fern#disable_default_mappings'] = 1

  local vim_fn = vim.fn

  vim.api.nvim_create_autocmd('FileType', {
    pattern = 'fern',
    callback = function()
      vim_fn['glyph_palette#apply']()

      local opt_local = vim.opt_local

      opt_local.number = false
      opt_local.relativenumber = false

      local keymap_set = vim.keymap.set

      keymap_set('n', '<Plug>(fern-action-open:side)',
        function()
          return vim_fn['fern#smart#drawer'](
            '<Plug>(fern-action-open:rightest)',
            '<Plug>(fern-action-open:vsplit)',
            '<Plug>(fern-action-open:vsplit)'
          )
        end, { buffer = true, expr = true })

      keymap_set(
        'n', '[',
        '<Plug>(fern-action-leave)',
        { buffer = true, nowait = true }
      )

      keymap_set(
        'n', ']',
        '<Plug>(fern-action-enter)',
        { buffer = true, nowait = true }
      )

      keymap_set(
        'n', 'wd',
        '<Plug>(fern-action-cd:root)',
        { buffer = true, nowait = true }
      )

      keymap_set(
        'n', '<CR>',
        '<Plug>(fern-action-open-or-expand)',
        { buffer = true, nowait = true }
      )

      keymap_set(
        'n', '<BS>',
        '<Plug>(fern-action-collapse)',
        { buffer = true, nowait = true }
      )

      keymap_set(
        'n', '<C-t>',
        '<Plug>(fern-action-open:tabedit)',
        { buffer = true, nowait = true }
      )

      keymap_set(
        'n', '<C-x>',
        '<Plug>(fern-action-open:split)',
        { buffer = true, nowait = true }
      )

      keymap_set(
        'n', '<C-v>',
        '<Plug>(fern-action-open:side)',
        { buffer = true, nowait = true }
      )

      keymap_set(
        'n', 'V',
        '<Plug>(fern-action-mark:toggle)',
        { buffer = true, nowait = true }
      )

      keymap_set(
        'n', 'n',
        '<Plug>(fern-action-new-path)',
        { buffer = true, nowait = true }
      )

      keymap_set(
        'n', 'nf',
        '<Plug>(fern-action-new-file)',
        { buffer = true, nowait = true }
      )

      keymap_set(
        'n', 'nd',
        '<Plug>(fern-action-new-dir)',
        { buffer = true, nowait = true }
      )

      keymap_set(
        'n', 'm',
        '<Plug>(fern-action-move)',
        { buffer = true, nowait = true }
      )

      keymap_set(
        'n', 'c',
        '<Plug>(fern-action-copy)',
        { buffer = true, nowait = true }
      )

      keymap_set(
        'n', 'd',
        '<Plug>(fern-action-remove)',
        { buffer = true, nowait = true }
      )

      keymap_set(
        'n', 'q',
        '<Cmd>quit<CR>',
        { buffer = true, nowait = true }
      )

      keymap_set(
        'n', '<F5>',
        '<Plug>(fern-action-reload)',
        { buffer = true, nowait = true }
      )
    end
  })
end

M.config = function()
  local keymap_set = vim.keymap.set

  keymap_set(
    'n', '<leader>ft',
    '<Cmd>Fern . -drawer -right -toggle<CR>',
    { silent = true }
  )

  keymap_set(
    'n', '<leader>fr',
    '<Cmd>Fern . -reveal=% -drawer -right -toggle<CR>',
    { silent = true }
  )
end

return M

