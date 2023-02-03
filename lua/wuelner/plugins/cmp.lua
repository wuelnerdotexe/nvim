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
    {
      "hrsh7th/cmp-cmdline",
      config = function()
        require("cmp").setup.cmdline({ "/", "?" }, {
          mapping = require("cmp").mapping.preset.cmdline({
            ["<C-z>"] = {
              c = function()
                if require("cmp").visible() then
                  require("cmp").select_next_item()
                else
                  require("cmp").complete()
                end
              end,
            },
            ["<C-e>"] = { c = require("cmp").mapping.abort() },
            ["<C-y>"] = { c = require("cmp").mapping.confirm({ select = false }) },
          }),
          sources = require("cmp").config.sources({ { name = "buffer", keyword_length = 1 } }),
        })

        require("cmp").setup.cmdline(":", {
          mapping = require("cmp").mapping.preset.cmdline({
            ["<C-z>"] = {
              c = function()
                if require("cmp").visible() then
                  require("cmp").select_next_item()
                else
                  require("cmp").complete()
                end
              end,
            },
            ["<C-e>"] = { c = require("cmp").mapping.abort() },
            ["<C-y>"] = { c = require("cmp").mapping.confirm({ select = false }) },
          }),
          sources = require("cmp").config.sources({
            { name = "path", keyword_length = 1 },
          }, {
            { name = "cmdline", keyword_length = 1 },
          }),
        })
      end,
    },
  },
  config = function()
    local tbl = {}

    vim.api.nvim_set_option_value("completeopt", "menu,menuone,noselect", tbl)

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

    require("cmp").setup({
      enabled = function()
        return (
          vim.api.nvim_get_option_value("buftype", { buf = 0 }) ~= "prompt"
          or (package.loaded["dap"] and require("cmp_dap").is_dap_buffer())
        )
          and vim.api.nvim_call_function("reg_recording", tbl) == ""
          and vim.api.nvim_call_function("reg_executing", tbl) == ""
      end,
      performance = { debounce = 40, throttle = 40, fetching_timeout = 300 },
      mapping = require("cmp").mapping.preset.insert({
        ["<C-p>"] = require("cmp").mapping(function()
          if require("cmp").visible() then
            require("cmp").select_prev_item()
          else
            require("cmp").complete()
          end
        end),
        ["<C-n>"] = require("cmp").mapping(function()
          if require("cmp").visible() then
            require("cmp").select_next_item()
          else
            require("cmp").complete()
          end
        end),
        ["<S-Tab>"] = require("cmp").mapping(function(fallback)
          if require("luasnip").locally_jumpable(-1) then
            require("luasnip").jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<Tab>"] = require("cmp").mapping(function(fallback)
          if require("luasnip").locally_jumpable(1) then
            require("luasnip").jump(1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      formatting = {
        fields = { "abbr", "kind" },
        format = function(entry, vim_item)
          if vim_item.kind == "Color" and entry.completion_item.documentation then
            local _, _, r, g, b = string.find(entry.completion_item.documentation, "^rgb%((%d+), (%d+), (%d+)")

            if r and g and b then
              local color = string.format("%02x", r) .. string.format("%02x", g) .. string.format("%02x", b)
              local group = "Tw_" .. color

              if vim.api.nvim_call_function("hlID", { group }) < 1 then
                vim.api.nvim_command("highlight" .. " " .. group .. " " .. "guifg=#" .. color)
              end

              vim_item.kind = "󱏿 Color"
              vim_item.kind_hl_group = group

              return vim_item
            end
          end

          vim_item.kind = entry.source.name == "cmp_tabnine" and " Tabnine"
            or codicons[vim_item.kind] .. " " .. vim_item.kind

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
              local current_buf = vim.api.nvim_get_current_buf()

              if vim.api.nvim_buf_get_offset(current_buf, vim.api.nvim_buf_line_count(current_buf)) > 1048576 then
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
        documentation = { border = "rounded", winhighlight = "FloatBorder:FloatBorder" },
      },
    })

    require("cmp").setup.filetype({
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
