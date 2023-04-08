require("wuelnerdotexe.plugin.util").set_option("signcolumn", "yes:1")

local borderstyle = require("wuelnerdotexe.plugin.util").get_border().style

vim.diagnostic.config({
  signs = { priority = require("wuelnerdotexe.plugin.config").signs_priority.diagnostic },
  virtual_text = false,
  virtual_lines = true,
  float = { header = { "Diagnostics", "Title" }, border = borderstyle },
  update_in_insert = true,
  severity_sort = true,
})

local ref_floating_preview = vim.lsp.util.open_floating_preview

vim.lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = borderstyle

  return ref_floating_preview(contents, syntax, opts, ...)
end

return {
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
      "b0o/schemastore.nvim",
      {
        "williamboman/mason-lspconfig.nvim",
        dependencies = "williamboman/mason.nvim",
        config = function()
          require("mason-lspconfig").setup({
            ensure_installed = {
              "bashls",
              "cssls",
              "docker_compose_language_service",
              "dockerls",
              "eslint",
              "html",
              "jsonls",
              "tailwindcss",
              "tsserver",
              "yamlls",
            },
          })
        end,
      },
    },
    init = function() require("wuelnerdotexe.plugin.util").set_option("signcolumn", "yes:1") end,
    config = function()
      require("lspconfig.ui.windows").default_options.border = borderstyle

      local basic_server_setup = {
        flags = { debounce_text_changes = 284 },
        on_attach = function(client, bufnr) require("wuelnerdotexe.plugin.start.lsp.attach")(client, bufnr) end,
      }

      local ok_cmp_nvim_lsp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")

      if ok_cmp_nvim_lsp then basic_server_setup.capabilities = cmp_nvim_lsp.default_capabilities() end

      require("lspconfig").jsonls.setup(vim.tbl_deep_extend("keep", {
        init_options = { provideFormatter = false },
        settings = { json = { schemas = require("schemastore").json.schemas(), validate = { enable = true } } },
      }, basic_server_setup))

      require("lspconfig").yamlls.setup(vim.tbl_deep_extend("keep", {
        settings = { yaml = { schemas = require("schemastore").json.schemas() } },
      }, basic_server_setup))

      require("lspconfig").bashls.setup(basic_server_setup)
      require("lspconfig").dockerls.setup(basic_server_setup)
      require("lspconfig").docker_compose_language_service.setup(basic_server_setup)

      require("lspconfig").html.setup(vim.tbl_deep_extend("keep", {
        init_options = { provideFormatter = false },
      }, basic_server_setup))

      local validate = { validate = false }

      require("lspconfig").cssls.setup(vim.tbl_deep_extend("keep", {
        settings = { css = validate, less = validate, scss = validate },
      }, basic_server_setup))

      require("lspconfig").tailwindcss.setup(basic_server_setup)

      require("lspconfig").tsserver.setup(vim.tbl_deep_extend("keep", {
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
              includeInlayVariableNameHintsWhenTypeMatchesName = true,
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
              includeInlayVariableNameHintsWhenTypeMatchesName = true,
            },
          },
        },
      }, basic_server_setup))

      require("lspconfig").eslint.setup(vim.tbl_deep_extend("keep", {
        settings = { format = false },
      }, basic_server_setup))
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "BufReadPre",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig",
      {
        "jay-babu/mason-null-ls.nvim",
        dependencies = "williamboman/mason.nvim",
        config = function()
          require("mason-null-ls").setup({
            ensure_installed = {
              "actionlint",
              "hadolint",
              "jsonlint",
              "markdownlint",
              "prettierd",
              "shfmt",
              "yamllint",
            },
          })
        end,
      },
    },
    init = function() require("wuelnerdotexe.plugin.util").set_option("signcolumn", "yes:1") end,
    config = function()
      require("null-ls").setup({
        border = borderstyle,
        update_in_insert = true,
        debounce = 284,
        on_attach = function(client, bufnr) require("wuelnerdotexe.plugin.start.lsp.attach")(client, bufnr) end,
        sources = {
          require("null-ls").builtins.diagnostics.markdownlint,
          require("null-ls").builtins.diagnostics.hadolint,
          require("null-ls").builtins.diagnostics.jsonlint,
          require("null-ls").builtins.diagnostics.yamllint,
          require("null-ls").builtins.diagnostics.actionlint,
          require("null-ls").builtins.formatting.shfmt,
          require("null-ls").builtins.formatting.prettierd.with({
            condition = function(utils)
              local config_files = require("lspconfig.util").insert_package_json({
                ".prettierrc",
                ".prettierrc.json",
                ".prettierrc.yml",
                ".prettierrc.yaml",
                ".prettierrc.json5",
                ".prettierrc.js",
                ".prettierrc.cjs",
                ".prettierrc.toml",
                "prettier.config.js",
                "prettier.config.cjs",
              }, "prettier")

              return utils.has_file(config_files) or utils.root_has_file(config_files)
            end,
          }),
        },
      })
    end,
  },
  {
    "kosayoda/nvim-lightbulb",
    event = "LspAttach",
    init = function() require("wuelnerdotexe.plugin.util").set_option("signcolumn", "yes:1") end,
    config = function()
      require("nvim-lightbulb").setup({
        sign = { priority = require("wuelnerdotexe.plugin.config").signs_priority.lightbulb },
        autocmd = { enabled = true },
      })

      vim.api.nvim_call_function(
        "sign_define",
        { "LightBulbSign", { text = "", texthl = "DiagnosticSignInfo", linehl = "", numhl = "" } }
      )
    end,
  },
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    event = "LspAttach",
    config = function()
      require("lsp_lines").setup()

      vim.api.nvim_set_keymap("n", "<leader>lt", "", { callback = function() require("lsp_lines").toggle() end })
    end,
  },
  {
    "lvimuser/lsp-inlayhints.nvim",
    lazy = true,
    init = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(ev)
          if not (ev.data and ev.data.client_id) then return end

          require("lsp-inlayhints").on_attach(vim.lsp.get_client_by_id(ev.data.client_id), ev.buf)
        end,
      })
    end,
    config = function()
      require("lsp-inlayhints").setup()

      vim.api.nvim_set_keymap("n", "<leader>ht", "", { callback = function() require("lsp-inlayhints").toggle() end })
    end,
  },
}
