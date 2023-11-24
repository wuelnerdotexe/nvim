return {
  {
    {
      "neovim/nvim-lspconfig",
      dependencies = {
        "williamboman/mason-lspconfig.nvim",
        dependencies = "williamboman/mason.nvim",
        cmd = { "LspInstall", "LspUninstall" },
        config = function()
          require("mason-lspconfig").setup({
            ensure_installed = { "cssls", "eslint", "html", "jsonls", "tailwindcss", "tsserver", "yamlls" },
          })
        end,
      },
      cmd = { "LspInfo", "LspLog", "LspRestart", "LspStart", "LspStop" },
      event = { "BufReadPost", "FileType" },
      init = function()
        require("wuelnerdotexe.plugin.util").add_colorscheme_integration("lspconfig")

        require("wuelnerdotexe.plugin.util").set_option("signcolumn", "yes:1")

        require("wuelnerdotexe.plugin.start.lsp.util").setup_lsp_diagnostics()

        table.insert(require("wuelnerdotexe.plugin.util").user_interface_filetypes, "lspinfo")
      end,
      config = function()
        require("lspconfig.ui.windows").default_options.border = "rounded"

        local basic_config = {
          flags = { debounce_text_changes = vim.api.nvim_get_option_value("updatetime", { scope = "global" }) },
          on_attach = function(...) require("wuelnerdotexe.plugin.start.lsp.util").on_attach(...) end,
          capabilities = pcall(require, "cmp_nvim_lsp") and require("cmp_nvim_lsp").default_capabilities()
            or vim.lsp.protocol.make_client_capabilities(),
        }

        basic_config.capabilities.textDocument.foldingRange = { dynamicRegistration = false, lineFoldingOnly = true }

        require("lspconfig").jsonls.setup(vim.tbl_deep_extend("error", {
          on_new_config = function(new_config)
            vim.list_extend(new_config.settings.json.schemas or {}, require("schemastore").json.schemas())
          end,
          settings = { json = { validate = { enable = true } } },
        }, basic_config))

        require("lspconfig").yamlls.setup(vim.tbl_deep_extend("error", {
          on_new_config = function(new_config)
            vim.list_extend(new_config.settings.yaml.schemas or {}, require("schemastore").yaml.schemas())
          end,
          settings = { yaml = { validate = true, schemaStore = { enable = false, url = "" } } },
        }, basic_config))

        require("lspconfig").html.setup(vim.tbl_deep_extend("error", {}, basic_config))
        require("lspconfig").cssls.setup(vim.tbl_deep_extend("error", {}, basic_config))
        require("lspconfig").tailwindcss.setup(vim.tbl_deep_extend("error", {}, basic_config))

        require("lspconfig").tsserver.setup(vim.tbl_deep_extend("error", {
          settings = {
            javascript = {
              inlayHints = {
                includeInlayEnumMemberValueHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayVariableTypeHintsWhenTypeMatchesName = true,
              },
            },
            typescript = {
              inlayHints = {
                includeInlayEnumMemberValueHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayVariableTypeHintsWhenTypeMatchesName = true,
              },
            },
          },
        }, basic_config))

        require("lspconfig").eslint.setup(vim.tbl_deep_extend("error", {}, basic_config))
      end,
    },
    { "b0o/schemastore.nvim", lazy = true },
    {
      "mrjones2014/smart-splits.nvim",
      optional = true,
      opts = function(_, opts) opts.ignored_filetypes = vim.list_extend(opts.ignored_filetypes or {}, { "lspinfo" }) end,
    },
  },
  {
    {
      "jose-elias-alvarez/null-ls.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim",
        {
          "jay-babu/mason-null-ls.nvim",
          dependencies = "williamboman/mason.nvim",
          cmd = { "NullLsInstall", "NullLsUninstall" },
          config = function()
            require("mason-null-ls").setup({
              ensure_installed = { "actionlint", "jsonlint", "markdownlint", "prettierd", "yamllint" },
            })
          end,
        },
      },
      cmd = { "NullLsInfo", "NullLsLog" },
      event = { "BufRead", "FileType" },
      init = function()
        require("wuelnerdotexe.plugin.util").add_colorscheme_integration("null-ls")

        require("wuelnerdotexe.plugin.util").set_option("signcolumn", "yes:1")

        require("wuelnerdotexe.plugin.start.lsp.util").setup_lsp_diagnostics()

        table.insert(require("wuelnerdotexe.plugin.util").user_interface_filetypes, "null-ls-info")
      end,
      config = function()
        require("null-ls").setup({
          border = "rounded",
          debounce = vim.api.nvim_get_option_value("updatetime", { scope = "global" }),
          diagnostic_config = { severity_sort = true },
          on_attach = function(client, bufnr) require("wuelnerdotexe.plugin.start.lsp.util").on_attach(client, bufnr) end,
          sources = {
            require("null-ls").builtins.diagnostics.jsonlint,
            require("null-ls").builtins.diagnostics.yamllint,
            require("null-ls").builtins.diagnostics.actionlint,
            require("null-ls").builtins.diagnostics.markdownlint,
            require("null-ls").builtins.formatting.prettierd,
          },
          update_in_insert = true,
        })
      end,
    },
    {
      "mrjones2014/smart-splits.nvim",
      optional = true,
      opts = function(_, opts) opts.ignored_filetypes = vim.list_extend(opts.ignored_filetypes or {}, { "null-ls-info" }) end,
    },
  },
  {
    {
      "SmiteshP/nvim-navic",
      event = "LspAttach",
      init = function() require("wuelnerdotexe.plugin.util").add_colorscheme_integration("navic") end,
      config = function()
        require("nvim-navic").setup({
          icons = {
            File = " ",
            Module = " ",
            Namespace = " ",
            Package = " ",
            Class = " ",
            Method = " ",
            Property = " ",
            Field = " ",
            Constructor = " ",
            Enum = " ",
            Interface = " ",
            Function = " ",
            Variable = " ",
            Constant = " ",
            String = " ",
            Number = " ",
            Boolean = " ",
            Array = " ",
            Object = " ",
            Key = " ",
            Null = "ﳠ ",
            EnumMember = " ",
            Struct = " ",
            Event = " ",
            Operator = " ",
            TypeParameter = " ",
          },
          lsp = { auto_attach = true },
          highlight = true,
          depth_limit_indicator = "⋯",
        })
      end,
    },
    {
      "freddiehaddad/feline.nvim",
      optional = true,
      opts = function()
        require("feline").winbar.setup({
          components = {
            active = {
              {
                { update = false, provider = " ", hl = { name = "FelineIndicator", fg = "bg" }, priority = 1 },
                {
                  enabled = function() return not package.loaded["bufferline"] end,
                  provider = { name = "file_info", opts = { file_readonly_icon = " ", type = "unique" } },
                  right_sep = { str = " > ", hl = { fg = "fg" } },
                  hl = { name = "FelineFilenameWinbar", fg = "accent", style = "bold" },
                },
                {
                  provider = function()
                    if not package.loaded["nvim-navic"] or not require("nvim-navic").is_available() then
                      return "no elements"
                    end

                    local location = require("nvim-navic").get_location()

                    return location == "" and "⋯" or location
                  end,
                  hl = { name = "FelineWinbar", fg = "fg" },
                  priority = -1,
                },
              },
            },
            inactive = {
              {
                { update = false, provider = " ", hl = { name = "FelineIndicatorInactive", fg = "bg" }, priority = 1 },
                {
                  enabled = function() return not package.loaded["bufferline"] end,
                  provider = { name = "file_info", opts = { file_readonly_icon = " ", type = "unique" } },
                  right_sep = { str = " > ", hl = { fg = "gray" } },
                  hl = { name = "FelineFilenameInactiveWinbar", fg = "darkaccent", style = "bold" },
                },
                {
                  provider = function()
                    if not package.loaded["nvim-navic"] or not require("nvim-navic").is_available() then
                      return "no elements"
                    end

                    local location = require("nvim-navic").get_location()

                    return location == "" and "⋯" or location
                  end,
                  hl = { name = "FelineInactiveWinbar", fg = "gray" },
                  priority = -1,
                },
              },
            },
          },
          disable = {
            buftypes = { "^help$", "^loclist$", "^nofile$", "^prompt$", "^quickfix$", "^terminal$" },
            filetypes = { "^netrw$" },
          },
        })
      end,
    },
  },
  {
    "VidocqH/lsp-lens.nvim",
    cmd = { "LspLensOff", "LspLensOn", "LspLensToggle" },
    event = "LspAttach",
    init = function() require("wuelnerdotexe.plugin.util").add_colorscheme_integration("lsp-lens") end,
    config = function()
      require("lsp-lens").setup({ ignore_filetype = require("wuelnerdotexe.plugin.util").user_interface_filetypes })
    end,
  },
  {
    "kosayoda/nvim-lightbulb",
    event = "LspAttach",
    init = function() require("wuelnerdotexe.plugin.util").set_option("signcolumn", "yes:1") end,
    config = function()
      require("nvim-lightbulb").setup({
        priority = 2,
        sign = { text = "" },
        virtual_text = { text = "" },
        float = { text = "" },
        status_text = { text = "" },
        autocmd = { enabled = true, updatetime = vim.api.nvim_get_option_value("updatetime", { scope = "global" }) },
        ignore = { ft = require("wuelnerdotexe.plugin.util").user_interface_filetypes },
      })
    end,
  },
  {
    "soulis-1256/hoverhints.nvim",
    cond = not os.getenv("TMUX"),
    event = "LspAttach",
    init = function() require("wuelnerdotexe.plugin.util").set_option("mousemoveevent", true) end,
    config = function()
      require("hoverhints").setup({
        scrollbar_offset = 1,
        render_delay = vim.api.nvim_get_option_value("timeoutlen", { scope = "global" }),
        detect_mouse_timer = vim.api.nvim_get_option_value("updatetime", { scope = "global" }),
        border = "rounded",
        title_pos = "center",
        error_color = require("wuelnerdotexe.plugin.util").get_scheme_color("DiagnosticFloatingError", "fg"),
        warning_color = require("wuelnerdotexe.plugin.util").get_scheme_color("DiagnosticWarnError", "fg"),
        info_color = require("wuelnerdotexe.plugin.util").get_scheme_color("DiagnosticInfoError", "fg"),
        hint_color = require("wuelnerdotexe.plugin.util").get_scheme_color("DiagnosticHintError", "fg"),
        generic_color = require("wuelnerdotexe.plugin.util").get_scheme_color("Accent", "fg"),
      })
    end,
  },
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    keys = {
      {
        "<leader>lt",
        function() require("lsp_lines").toggle() end,
        desc = "Language server: [t]oggle [l]ines diagnostic",
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("UIEnter", {
        callback = function() vim.diagnostic.config({ virtual_text = false, virtual_lines = false }) end,
      })
    end,
    config = function() require("lsp_lines").setup() end,
  },
}
