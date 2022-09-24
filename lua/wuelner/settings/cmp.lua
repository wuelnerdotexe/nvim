local M = {}

M.config = function()
  vim.opt.complete = nil

  local cmp = require('cmp')
  local lspkind = require('lspkind')
  local luasnip = require('luasnip')

  local has_words_before = function()
    local vim_api = vim.api
    local line, col = unpack(vim_api.nvim_win_get_cursor(0))

    return col ~= 0 and vim_api.nvim_buf_get_lines(
      0, line - 1, line, true)[1]:sub(col, col
      ):match('%s') == nil
  end

  local cmp_mapping = cmp.mapping
  local cmp_setup = cmp.setup

  cmp_setup({
    snippet = { expand = function(args)
      luasnip.lsp_expand(args.body)
    end },
    mapping = cmp_mapping.preset.insert({
      ['<C-b>'] = cmp_mapping.scroll_docs(-3),
      ['<C-f>'] = cmp_mapping.scroll_docs(3),
      ['<C-e>'] = cmp_mapping.abort(),
      ['<CR>'] = cmp_mapping.confirm({ select = false }),
      ['<S-Tab>'] = cmp_mapping(function(fallback)
        if cmp.visible()
        then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1)
        then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<Tab>'] = cmp_mapping(function(fallback)
        if cmp.visible()
        then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable()
        then
          luasnip.expand_or_jump()
        elseif has_words_before()
        then
          cmp.complete()
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<C-p>'] = cmp_mapping(function()
        if cmp.visible()
        then
          cmp.select_prev_item()
        else
          cmp.complete()
        end
      end, { 'i', 's' }),
      ['<C-n>'] = cmp_mapping(function()
        if cmp.visible()
        then
          cmp.select_next_item()
        else
          cmp.complete()
        end
      end, { 'i', 's' })
    }),
    experimental = {
      ghost_text = true
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'cmp_tabnine' }
    }, { { name = 'buffer' } }),
    keyword_length = 1,
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

          if entry.source.name == 'cmp_tabnine'
          then
            vim_item.kind = string.format('%s %s', '', 'Tabnine')
          end

          return vim_item
        end
      })
    }
  })

  cmp_setup.filetype({
    'checkhealth',
    'fern',
    'fugitive',
    'fugitiveblame',
    'fzf',
    'lspinfo',
    'mason',
    'nerdterm',
    'packer',
    'qf',
    'null-ls-info'
  }, { enabled = false })
end

return M

