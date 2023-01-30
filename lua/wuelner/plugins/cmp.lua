return {
  "hrsh7th/nvim-cmp",
  event = { "BufNewFile", "BufRead", "BufAdd" },
  dependencies = {
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-buffer",
    { "jackieaskins/cmp-emmet", build = "npm run release" },
    {
      "L3MON4D3/LuaSnip",
      build = "make install_jsregexp",
      dependencies = { "saadparwaiz1/cmp_luasnip", "rafamadriz/friendly-snippets" },
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
    {
      "tzachar/cmp-tabnine",
      build = "./install.sh",
      config = function()
        vim.schedule(function()
          require("cmp_tabnine.config").setup({
            ignored_file_types = {
              ["aerial"] = true,
              ["checkhealth"] = true,
              ["dap-repl"] = true,
              ["dapui_breakpoints"] = true,
              ["dapui_console"] = true,
              ["dapui_hover"] = true,
              ["dapui_scopes"] = true,
              ["dapui_stacks"] = true,
              ["dapui_watches"] = true,
              ["DressingInput"] = true,
              ["DressingSelect"] = true,
              ["fern"] = true,
              ["lazy"] = true,
              ["lspinfo"] = true,
              ["mason"] = true,
              ["nerdterm"] = true,
              ["noice"] = true,
              ["notify"] = true,
              ["null-ls-info"] = true,
              ["qf"] = true,
              ["TelescopePrompt"] = true,
            },
          })
        end)
      end,
    },
  },
  config = function()
    local set_option_value = vim.api.nvim_set_option_value
    local tbl = {}

    set_option_value("complete", nil, tbl)
    set_option_value("completeopt", "menuone,noselect", tbl)

    local win_get_cursor = vim.api.nvim_win_get_cursor
    local buf_get_lines = vim.api.nvim_buf_get_lines
    local has_words_before = function()
      local line, col = unpack(win_get_cursor(0))

      return col ~= 0 and buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    local setup = require("cmp").setup
    local get_option_value = vim.api.nvim_get_option_value
    local call_function = vim.api.nvim_call_function
    local mapping = require("cmp").mapping
    local scroll_docs = mapping.scroll_docs
    local visible = require("cmp").visible
    local complete = require("cmp").complete
    local select_next_item = require("cmp").select_next_item
    local select_prev_item = require("cmp").select_prev_item
    local mapping_mode = { "i", "s" }

    local string_find = string.find
    local string_format = string.format
    local command = vim.api.nvim_command
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

    local get_current_buf = vim.api.nvim_get_current_buf
    local buf_get_offset = vim.api.nvim_buf_get_offset
    local buf_line_count = vim.api.nvim_buf_line_count

    setup({
      enabled = function()
        return (
          get_option_value("buftype", { buf = 0 }) ~= "prompt"
          or (package.loaded["dap"] and require("cmp_dap").is_dap_buffer())
        )
          and call_function("reg_recording", tbl) == ""
          and call_function("reg_executing", tbl) == ""
      end,
      performance = { debounce = 40, throttle = 40, fetching_timeout = 300 },
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
          local documentation = entry.completion_item.documentation

          if kind == "Color" and documentation then
            local _, _, r, g, b = string_find(documentation, "^rgb%((%d+), (%d+), (%d+)")

            if r and g and b then
              local color = string_format("%02x", r) .. string_format("%02x", g) .. string_format("%02x", b)
              local group = "Tw_" .. color

              if call_function("hlID", { group }) < 1 then
                command("highlight" .. " " .. group .. " " .. "guifg=#" .. color)
              end

              vim_item.kind = "󱏿 Color"
              vim_item.kind_hl_group = group

              return vim_item
            end
          end

          vim_item.kind = entry.source.name == "cmp_tabnine" and " Tabnine" or codicons[kind] .. " " .. kind

          return vim_item
        end,
      },
      sorting = {
        comparators = {
          require("cmp.config.compare").scopes,
          require("cmp.config.compare").score,
          require("cmp.config.compare").exact,
          require("cmp.config.compare").order,
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
              local current_buf = get_current_buf()

              if buf_get_offset(current_buf, buf_line_count(current_buf)) > 1048576 then
                return tbl
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

    setup.filetype({
      "aerial",
      "checkhealth",
      "dapui_breakpoints",
      "dapui_console",
      "dapui_scopes",
      "dapui_stacks",
      "DressingInput",
      "DressingSelect",
      "fern",
      "lazy",
      "lspinfo",
      "mason",
      "nerdterm",
      "noice",
      "notify",
      "null-ls-info",
      "qf",
      "TelescopePrompt",
    }, { enabled = false })

    require("cmp").event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())
  end,
}
