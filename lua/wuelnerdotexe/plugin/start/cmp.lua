return {
  {
    "hrsh7th/nvim-cmp",
    lazy = true,
    dependencies = "nvim-treesitter/nvim-treesitter",
    init = function() require("wuelnerdotexe.plugin.util").set_option("completeopt", "menu,menuone,noselect") end,
    config = function()
      require("cmp").setup({
        enabled = function()
          return (
            vim.api.nvim_get_option_value("buftype", { buf = 0 }) ~= "prompt"
            or (package.loaded["dap"] and require("cmp_dap").is_dap_buffer())
          )
            and vim.api.nvim_call_function("reg_recording", TBL) == ""
            and vim.api.nvim_call_function("reg_executing", TBL) == ""
        end,
        performance = { debounce = 42, throttle = 42, fetching_timeout = 284 },
        mapping = require("cmp").mapping.preset.insert({
          ["<C-Space>"] = { i = require("cmp").mapping.complete() },
          ["<CR>"] = { i = require("cmp").mapping.confirm({ select = false }) },
        }),
        snippet = {
          expand = function(args)
            if package.loaded["luasnip"] then
              require("luasnip").lsp_expand(args.body)
            else
              error("snippet engine is not configured.")
            end
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

                vim_item.kind = " Color"
                vim_item.kind_hl_group = group

                return vim_item
              end
            elseif entry.source.name == "cmp_tabnine" then
              vim_item.kind = " Tabnine"

              return vim_item
            end

            vim_item.kind = require("wuelnerdotexe.plugin.config").kind_icons[vim_item.kind] .. " " .. vim_item.kind

            return vim_item
          end,
        },
        matching = { disallow_partial_fuzzy_matching = false },
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
          { name = "buffer", option = { indexing_interval = 284 }, keyword_length = 3, priority = 1 },
        }),
        confirmation = { default_behavior = require("cmp.types").cmp.ConfirmBehavior.Replace },
        experimental = { ghost_text = { hl_group = "Dimmed" } },
        window = {
          completion = { scrolloff = 3 },
          documentation = {
            border = require("wuelnerdotexe.plugin.config").border and "rounded" or "none",
            winhighlight = "FloatBorder:FloatBorder",
          },
        },
      })

      require("cmp").event:on("menu_opened", function()
        if vim.api.nvim_get_mode().mode:sub(1, 1) ~= "c" then
          vim.api.nvim_exec_autocmds("User", { pattern = "IntPairsComp" })
        end
      end)

      require("cmp").setup.filetype(require("wuelnerdotexe.plugin.config").uifiletypes, { enabled = false })
    end,
  },
  { "hrsh7th/cmp-path", event = "InsertEnter", dependencies = "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-buffer", event = "InsertEnter", dependencies = "hrsh7th/nvim-cmp" },
  {
    "hrsh7th/cmp-cmdline",
    event = "CmdlineEnter",
    dependencies = { "hrsh7th/nvim-cmp", "hrsh7th/cmp-path", "hrsh7th/cmp-buffer" },
    config = function()
      require("cmp").setup.cmdline({ "/", "?" }, {
        mapping = require("cmp").mapping.preset.cmdline(),
        sources = require("cmp").config.sources({
          { name = "buffer", option = { indexing_interval = 284 }, keyword_length = 1, priority = 1 },
        }),
      })

      require("cmp").setup.cmdline(":", {
        mapping = require("cmp").mapping.preset.cmdline(),
        sources = require("cmp").config.sources({
          { name = "path", keyword_length = 1, priority = 2 },
        }, {
          { name = "cmdline", keyword_length = 1, priority = 1 },
        }),
      })
    end,
  },
  { "saadparwaiz1/cmp_luasnip", event = "InsertEnter", dependencies = { "hrsh7th/nvim-cmp", "L3MON4D3/LuaSnip" } },
  {
    "hrsh7th/cmp-nvim-lsp",
    lazy = true,
    dependencies = { "hrsh7th/nvim-cmp", "L3MON4D3/LuaSnip" },
    init = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("load_cmp_nvim_lsp", { clear = false }),
        callback = function(ev)
          if package.loaded["cmp_nvim_lsp"] then return true end

          vim.api.nvim_create_autocmd("InsertEnter", {
            buffer = ev.buf,
            group = "load_cmp_nvim_lsp",
            callback = function()
              vim.api.nvim_clear_autocmds({ group = "load_cmp_nvim_lsp" })

              require("lazy").load({ plugins = { "cmp-nvim-lsp" } })
            end,
          })
        end,
      })
    end,
  },
  {
    "tzachar/cmp-tabnine",
    build = "./install.sh",
    enabled = not require("wuelnerdotexe.plugin.config").minimal_setup,
    lazy = true,
    dependencies = "hrsh7th/nvim-cmp",
    init = function()
      vim.api.nvim_create_autocmd("BufReadPre", {
        pattern = "*.css,*.sass,*.html,*.js,*.jsx,*.ts,*.tsx",
        callback = function(ev) require("cmp_tabnine"):prefetch(ev.file) end,
      })
    end,
    config = function()
      local ignored_file_types = {}

      for _, uifiletype in pairs(require("wuelnerdotexe.plugin.config").uifiletypes) do
        ignored_file_types[uifiletype] = true
      end

      require("cmp_tabnine.config"):setup({ ignored_file_types = ignored_file_types })
    end,
  },
  {
    "jackieaskins/cmp-emmet",
    build = "npm run release",
    dependencies = "hrsh7th/nvim-cmp",
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "html,xml,typescriptreact,javascriptreact,css,sass,scss,less",
        group = vim.api.nvim_create_augroup("load_cmp_emmet", { clear = false }),
        callback = function(ev)
          if package.loaded["cmp-emmet"] then return true end

          vim.api.nvim_create_autocmd("InsertEnter", {
            buffer = ev.buf,
            group = "load_cmp_emmet",
            callback = function()
              vim.api.nvim_clear_autocmds({ group = "load_cmp_emmet" })

              require("lazy").load({ plugins = { "cmp-emmet" } })
            end,
          })
        end,
      })
    end,
  },
  {
    "rcarriga/cmp-dap",
    lazy = true,
    dependencies = "hrsh7th/nvim-cmp",
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "dap-repl,dapui_watches,dapui_hover",
        group = vim.api.nvim_create_augroup("load_cmp_dap", { clear = false }),
        callback = function(ev)
          if package.loaded["cmp_dap"] then return true end

          vim.api.nvim_create_autocmd("InsertEnter", {
            buffer = ev.buf,
            group = "load_cmp_dap",
            callback = function()
              vim.api.nvim_clear_autocmds({ group = "load_cmp_dap" })

              require("lazy").load({ plugins = { "cmp-dap" } })
            end,
          })
        end,
      })
    end,
    config = function()
      require("cmp").setup.filetype(
        { "dap-repl", "dapui_watches", "dapui_hover" },
        { sources = require("cmp").config.sources({ { name = "dap", keyword_lenght = 1 } }) }
      )
    end,
  },
}
