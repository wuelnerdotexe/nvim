return {
  {
    {
      "hrsh7th/nvim-cmp",
      cmd = "CmpStatus",
      lazy = true,
      init = function()
        require("wuelnerdotexe.plugin.util").add_colorscheme_integration("cmp")

        require("wuelnerdotexe.plugin.util").set_option("completeopt", "menu,menuone,noselect")

        vim.list_extend(require("wuelnerdotexe.plugin.util").user_interface_filetypes, { "cmp_docs", "cmp_menu" })
      end,
      config = function()
        require("cmp").setup({
          enabled = function()
            local buftype = vim.api.nvim_get_option_value("buftype", { buf = 0 })

            return (not vim.tbl_contains({ "help", "loclist", "nofile", "quickfix", "terminal" }, buftype))
              and (buftype ~= "prompt" or (package.loaded["cmp_dap"] and require("cmp_dap").is_dap_buffer()))
              and vim.api.nvim_call_function("reg_recording", {}) == ""
              and vim.api.nvim_call_function("reg_executing", {}) == ""
          end,
          performance = { debounce = 42, throttle = 42, fetching_timeout = 300 },
          mapping = require("cmp").mapping.preset.insert(),
          snippet = {
            expand = function(args)
              if pcall(require, "luasnip") then
                require("luasnip").lsp_expand(args.body)
              else
                error("snippet engine is not configured.")
              end
            end,
          },
          formatting = {
            fields = require("wuelnerdotexe.plugin.start.cmp.util").formatting.fields,
            format = function(...) return require("wuelnerdotexe.plugin.start.cmp.util").formatting.format(...) end,
          },
          matching = { disallow_partial_fuzzy_matching = false },
          sorting = {
            comparators = {
              function(...) return require("cmp.config.compare").exact(...) end,
              function(...) return require("cmp.config.compare").score(...) end,
              function(...) return require("cmp.config.compare").length(...) end,
              function(...) return require("cmp.config.compare").sort_text(...) end,
            },
          },
          sources = require("cmp").config.sources(
            { { name = "path" } },
            { { priority = 6, name = "luasnip" }, { priority = 4, name = "nvim_lsp" } },
            { { name = "buffer", option = { keyword_length = 1, indexing_interval = 171 } } }
          ),
          confirmation = { default_behavior = require("cmp.types").cmp.ConfirmBehavior.Replace },
          experimental = {
            ghost_text = require("lazy.core.config").spec.plugins["tabnine-nvim"] == nil and {
              hl_group = "LspCodeLens",
            } or false,
          },
          window = {
            completion = { scrolloff = vim.api.nvim_get_option_value("scrolloff", { scope = "global" }) },
            documentation = { winhighlight = "FloatBorder:FloatBorder" },
          },
        })

        require("cmp").setup.filetype(
          require("wuelnerdotexe.plugin.util").user_interface_filetypes,
          { enabled = false }
        )
      end,
    },
    {
      "NvChad/nvim-colorizer.lua",
      optional = true,
      ft = "cmp_docs",
      opts = { filetypes = { cmp_docs = { css_fn = true, sass = { enable = true }, always_update = true } } },
    },
    {
      "petertriho/nvim-scrollbar",
      optional = true,
      opts = function(_, opts)
        opts.excluded_filetypes = vim.list_extend(opts.excluded_filetypes or {}, { "cmp_docs", "cmp_menu" })
      end,
    },
  },
  { "hrsh7th/cmp-path", dependencies = "hrsh7th/nvim-cmp", event = "InsertEnter" },
  { "hrsh7th/cmp-buffer", dependencies = "hrsh7th/nvim-cmp", event = "InsertEnter" },
  {
    "hrsh7th/cmp-cmdline",
    dependencies = "hrsh7th/nvim-cmp",
    event = "CmdlineEnter",
    config = function()
      require("cmp").setup.cmdline({ "/", "?" }, {
        mapping = require("cmp").mapping.preset.cmdline(),
        sources = { { name = "buffer", option = { keyword_length = 1, indexing_interval = 171 } } },
      })

      require("cmp").setup.cmdline(":", {
        mapping = require("cmp").mapping.preset.cmdline(),
        sources = require("cmp").config.sources({ { name = "path" } }, { { name = "cmdline" } }),
      })
    end,
  },
  {
    "saadparwaiz1/cmp_luasnip",
    dependencies = { "L3MON4D3/LuaSnip", { "hrsh7th/nvim-cmp", dependencies = "L3MON4D3/LuaSnip" } },
    event = "InsertEnter",
  },
  {
    "hrsh7th/cmp-nvim-lsp",
    dependencies = { "hrsh7th/nvim-cmp", dependencies = "L3MON4D3/LuaSnip" },
    lazy = true,
    init = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("load_cmp_nvim_lsp", { clear = false }),
        callback = function(ev)
          if package.loaded["cmp_nvim_lsp"] then
            vim.api.nvim_clear_autocmds({ group = ev.group })

            return true
          end

          vim.api.nvim_create_autocmd("InsertEnter", {
            buffer = ev.buf,
            group = ev.group,
            callback = function()
              vim.api.nvim_clear_autocmds({ group = ev.group })

              require("lazy").load({ plugins = { "cmp-nvim-lsp" } })
            end,
          })
        end,
      })
    end,
  },
  {
    "rcarriga/cmp-dap",
    dependencies = "hrsh7th/nvim-cmp",
    event = [[InsertEnter *dap-repl*,DAP\ Watches,DAP\ Hover]],
    config = function()
      require("cmp").setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, { sources = { { name = "dap" } } })
    end,
  },
}
