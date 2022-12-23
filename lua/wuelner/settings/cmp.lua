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

  local setup = require("cmp").setup
  local mapping = require("cmp").mapping
  local scroll_docs = mapping.scroll_docs
  local visible = require("cmp").visible
  local complete = require("cmp").complete
  local select_next_item = require("cmp").select_next_item
  local select_prev_item = require("cmp").select_prev_item
  local mapping_mode = { "i", "s" }
  local string_format = string.format
  local codicons = {
    Text = "",
    Method = "",
    Function = "",
    Constructor = "",
    Field = "",
    Variable = "",
    Class = "",
    Interface = "",
    Module = "",
    Property = "",
    Unit = "",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "",
    Event = "",
    Operator = "",
    TypeParameter = "",
  }

  setup({
    enabled = function()
      return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
        or require("cmp_dap").is_dap_buffer()
    end,
    performance = { debounce = 300, throttle = 40, fetching_timeout = 300 },
    mapping = mapping.preset.insert({
      ["<C-b>"] = scroll_docs(-1),
      ["<C-f>"] = scroll_docs(1),
      ["<C-e>"] = mapping.abort(),
      ["<CR>"] = mapping.confirm({ select = false }),
      ["<S-Tab>"] = mapping(function(fallback)
        if visible() then
          select_prev_item()
        elseif require("luasnip").jumpable(-1) then
          require("luasnip").jump(-1)
        else
          fallback()
        end
      end, mapping_mode),
      ["<Tab>"] = mapping(function(fallback)
        if visible() then
          select_next_item()
        elseif require("luasnip").expand_or_locally_jumpable() then
          require("luasnip").expand_or_jump()
        elseif has_words_before() then
          complete()
        else
          fallback()
        end
      end, mapping_mode),
      ["<C-p>"] = mapping(function()
        if visible() then
          select_prev_item()
        else
          complete()
        end
      end, mapping_mode),
      ["<C-n>"] = mapping(function()
        if visible() then
          select_next_item()
        else
          complete()
        end
      end, mapping_mode),
    }),
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },
    completion = { completeopt = "menuone,noselect" },
    formatting = {
      fields = { "abbr", "kind" },
      format = function(entry, vim_item)
        local kind = vim_item.kind

        vim_item.kind = string_format("%s %s", codicons[kind], kind)

        if entry.source.name == "cmp_tabnine" then
          vim_item.kind = string_format("%s %s", "", "Tabnine")
        end

        return vim_item
      end,
    },
    sorting = {
      comparators = {
        function(...)
          return require("cmp_buffer"):compare_locality(...)
        end,
      },
    },
    sources = require("cmp").config.sources({
      { name = "path", keyword_length = 1, priority = 6 },
    }, {
      { name = "emmet", keyword_length = 1, priority = 5 },
      { name = "luasnip", keyword_length = 3, priority = 4 },
      { name = "nvim_lsp", keyword_length = 3, priority = 3 },
      { name = "cmp_tabnine", keyword_length = 3, priority = 2 },
    }, {
      {
        name = "buffer",
        option = {
          indexing_interval = 300,
          get_bufnrs = function()
            local current_buf = vim.api.nvim_get_current_buf()

            if
              vim.api.nvim_buf_get_offset(
                current_buf,
                vim.api.nvim_buf_line_count(current_buf)
              ) > 1048576
            then
              return {}
            end

            return { current_buf }
          end,
        },
        keyword_length = 3,
        priority = 1,
      },
    }),
    experimental = { ghost_text = true },
    window = {
      completion = { scrolloff = 3 },
      documentation = {
        border = "rounded",
        winhighlight = "FloatBorder:FloatBorder",
      },
    },
  })

  local setup_filetype = setup.filetype

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
    "fzf",
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
