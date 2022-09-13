local M = {}

M.config = function()
  local luasnip = require('luasnip')
  local cmp = require('cmp')
  local lspkind = require('lspkind')

  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))

    return col ~= 0 and vim.api.nvim_buf_get_lines(
      0, line - 1, line, true)[1]:sub(col, col
      ):match('%s') == nil
  end

  cmp.setup({
    snippet = { expand = function(args)
      luasnip.lsp_expand(args.body)
    end },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-3),
      ['<C-f>'] = cmp.mapping.scroll_docs(3),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = false }),
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { 'i', 's' })
    }),
    experimental = {
      ghost_text = true
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'treesitter' },
      { name = 'luasnip' },
      { name = 'cmp_tabnine' }
    }, { { name = 'buffer' } }),
    formatting = {
      fields = { 'abbr', 'kind' },
      format = lspkind.cmp_format({
        mode = 'symbol_text',
        before = function(entry, vim_item)
          vim_item.kind = string.format(
            '%s %s',
            lspkind.presets.codicons[vim_item.kind],
            vim_item.kind
          )

          if entry.source.name == 'cmp_tabnine' then
            vim_item.kind = string.format('%s %s', '', 'Tabnine')
          end

          return vim_item
        end
      })
    },
    keyword_length = 1
  })

  cmp.setup.filetype({
    'checkhealth',
    'dashboard',
    'fern',
    'fugitive',
    'fugitiveblame',
    'lspinfo',
    'man',
    'mason',
    'packer',
    'null-ls-info'
  }, { enabled = false })
end

return M

