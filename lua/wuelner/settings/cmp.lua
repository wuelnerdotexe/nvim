local M = {}

M.config = function()
  vim.opt.complete = nil

  local has_words_before = function()
    local line, col = table.unpack(vim.api.nvim_win_get_cursor(0))

    return col ~= 0
      and vim.api
          .nvim_buf_get_lines(0, line - 1, line, true)[1]
          :sub(col, col)
          :match("%s")
        == nil
  end
  local cmp_setup = require("cmp").setup
  local cmp_mapping = require("cmp").mapping
  local cmp_visible = require("cmp").visible
  local cmp_complete = require("cmp").complete
  local select_next_item = require("cmp").select_next_item
  local select_prev_item = require("cmp").select_prev_item

  cmp_setup({
    enabled = function()
      return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
        or require("cmp_dap").is_dap_buffer()
    end,
    performance = { debounce = 300, throttle = 40 },
    mapping = cmp_mapping.preset.insert({
      ["<C-b>"] = cmp_mapping.scroll_docs(-1),
      ["<C-f>"] = cmp_mapping.scroll_docs(1),
      ["<C-e>"] = cmp_mapping.abort(),
      ["<CR>"] = cmp_mapping.confirm({ select = false }),
      ["<S-Tab>"] = cmp_mapping(function(fallback)
        if cmp_visible() then
          select_prev_item()
        elseif require("luasnip").jumpable(-1) then
          require("luasnip").jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<Tab>"] = cmp_mapping(function(fallback)
        if cmp_visible() then
          select_next_item()
        elseif require("luasnip").expand_or_locally_jumpable() then
          require("luasnip").expand_or_jump()
        elseif has_words_before() then
          cmp_complete()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<C-p>"] = cmp_mapping(function()
        if cmp_visible() then
          select_prev_item()
        else
          cmp_complete()
        end
      end, { "i", "s" }),
      ["<C-n>"] = cmp_mapping(function()
        if cmp_visible() then
          select_next_item()
        else
          cmp_complete()
        end
      end, { "i", "s" }),
    }),
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },
    completion = { completeopt = "menuone,noselect", keyword_length = 1 },
    formatting = {
      fields = { "abbr", "kind" },
      format = require("lspkind").cmp_format({
        mode = "symbol_text",
        before = function(entry, vim_item)
          vim_item.kind = string.format(
            "%s %s",
            require("lspkind").presets.codicons[vim_item.kind],
            vim_item.kind
          )

          if entry.source.name == "cmp_tabnine" then
            vim_item.kind = string.format("%s %s", "", "Tabnine")
          end

          return vim_item
        end,
      }),
    },
    sorting = {
      comparators = {
        function(...)
          return require("cmp_buffer"):compare_locality(...)
        end,
      },
    },
    sources = require("cmp").config.sources({
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "cmp_tabnine" },
    }, {
      {
        name = "buffer",
        option = {
          keyword_length = 1,
          indexing_interval = 40,
          get_bufnrs = function()
            local buf = vim.api.nvim_get_current_buf()

            if
              vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))
              > 102400
            then
              return {}
            end

            return { buf }
          end,
        },
      },
    }),
    experimental = { ghost_text = true },
    window = {
      completion = { scrolloff = 3 },
      documentation = {
        border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
        winhighlight = "FloatBorder:FloatBorder",
      },
    },
  })

  local setup_filetype = cmp_setup.filetype

  setup_filetype({
    "dap-repl",
    "dapui_watches",
    "dapui_hover",
  }, { sources = { { name = "dap" } } })

  setup_filetype({
    "aerial",
    "checkhealth",
    "dapui_breakpoints",
    "dapui_console",
    "dapui_scopes",
    "dapui_stacks",
    "fern",
    "lspinfo",
    "mason",
    "nerdterm",
    "noice",
    "notify",
    "null-ls-info",
    "packer",
    "qf",
    "TelescopePrompt",
  }, { enabled = false })
end

return M
