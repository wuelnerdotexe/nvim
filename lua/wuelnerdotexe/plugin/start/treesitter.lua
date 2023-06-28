return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    keys = { { "<Space>", mode = { "n", "x" } }, { "<C-Space>", mode = "x" }, { "<BS>", mode = "x" } },
    cmd = {
      "TSBufDisable",
      "TSBufEnable",
      "TSBufToggle",
      "TSConfigInfo",
      "TSDisable",
      "TSEditQuery",
      "TSEditQueryUserAfter",
      "TSEnable",
      "TSInstall",
      "TSInstallFromGrammar",
      "TSInstallInfo",
      "TSInstallSync",
      "TSModuleInfo",
      "TSToggle",
      "TSUninstall",
      "TSUpdate",
      "TSUpdateSync",
    },
    event = "FileType",
    init = function() require("wuelnerdotexe.plugin.util").add_colorscheme_integration("treesitter") end,
    opts = function(_, opts)
      opts.ensure_installed = { "bash", "comment", "lua", "markdown", "markdown_inline", "regex", "vim" }
      opts.sync_install = true
      opts.auto_install = true
      opts.highlight = {
        enable = true,
        disable = function(_, buf)
          local stats = vim.loop.fs_stat(vim.api.nvim_buf_get_name(buf))

          if stats and stats.size > 102400 then return true end
        end,
        additional_vim_regex_highlighting = false,
      }
      opts.indent = { enable = true }
      opts.incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<Space>",
          node_incremental = "<Space>",
          scope_incremental = "<C-Space>",
          node_decremental = "<BS>",
        },
      }
    end,
    config = function(_, opts) require("nvim-treesitter.configs").setup(opts) end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      opts = function(_, opts) opts.textobjects = { select = { lookahead = true }, lsp_interop = { border = "rounded" } } end,
    },
    keys = {
      {
        "af",
        function() require("nvim-treesitter.textobjects.select").select_textobject("@function.outer") end,
        mode = "x",
      },
      {
        "if",
        function() require("nvim-treesitter.textobjects.select").select_textobject("@function.inner") end,
        mode = "x",
      },
      {
        "ac",
        function() require("nvim-treesitter.textobjects.select").select_textobject("@conditional.outer") end,
        mode = "x",
      },
      {
        "ic",
        function() require("nvim-treesitter.textobjects.select").select_textobject("@conditional.inner") end,
        mode = "x",
      },
      {
        "al",
        function() require("nvim-treesitter.textobjects.select").select_textobject("@loop.outer") end,
        mode = "x",
      },
      {
        "il",
        function() require("nvim-treesitter.textobjects.select").select_textobject("@loop.inner") end,
        mode = "x",
      },
      { "<Tab>", function() require("nvim-treesitter.textobjects.swap").swap_next("@parameter.inner") end },
      { "<S-Tab>", function() require("nvim-treesitter.textobjects.swap").swap_previous("@parameter.inner") end },
      { "gD", function() require("nvim-treesitter.textobjects.lsp_interop").peek_definition_code("@*.*") end },
    },
    cmd = {
      "TSTextobjectBuiltinf",
      "TSTextobjectBuiltinF",
      "TSTextobjectBuiltint",
      "TSTextobjectBuiltinT",
      "TSTextobjectGotoNextEnd",
      "TSTextobjectGotoNextStart",
      "TSTextobjectGotoPreviousEnd",
      "TSTextobjectGotoPreviousStart",
      "TSTextobjectPeekDefinitionCode",
      "TSTextobjectRepeatLastMove",
      "TSTextobjectRepeatLastMoveNext",
      "TSTextobjectRepeatLastMoveOpposite",
      "TSTextobjectRepeatLastMovePrevious",
      "TSTextobjectSelect",
      "TSTextobjectSwapNext",
      "TSTextobjectSwapPrevious",
    },
  },
  {
    "HiPhish/nvim-ts-rainbow2",
    dependencies = { "nvim-treesitter/nvim-treesitter", opts = function(_, opts) opts.rainbow = { enable = true } end },
    event = "FileType",
    init = function() require("wuelnerdotexe.plugin.util").add_colorscheme_integration("ts-rainbow2") end,
  },
  {
    "windwp/nvim-ts-autotag",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      opts = function(_, opts)
        opts.autotag = {
          enable = true,
          filetypes = { "html", "javascript", "javascriptreact", "typescriptreact", "markdown" },
        }
      end,
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "html,javascript,javascriptreact,typescriptreact,markdown",
        group = vim.api.nvim_create_augroup("load_nvim_ts_autotag", { clear = false }),
        callback = function(ev)
          if package.loaded["nvim-ts-autotag"] then
            vim.api.nvim_clear_autocmds({ group = ev.group })

            return true
          end

          vim.api.nvim_create_autocmd("InsertEnter", {
            buffer = ev.buf,
            group = ev.group,
            callback = function()
              vim.api.nvim_clear_autocmds({ group = ev.group })

              require("lazy").load({ plugins = { "nvim-ts-autotag" } })
            end,
          })
        end,
      })
    end,
    config = function() vim.api.nvim_command("doautoall <nomodeline> FileType") end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = "nvim-treesitter/nvim-treesitter",
    keys = { { "[c", function() require("treesitter-context").go_to_context() end } },
    cmd = { "TSContextDisable", "TSContextEnable", "TSContextToggle" },
    event = { "BufReadPost", "FileType" },
    init = function() require("wuelnerdotexe.plugin.util").add_colorscheme_integration("treesitter-context") end,
    config = function()
      require("treesitter-context").setup({
        max_lines = 400,
        min_window_height = vim.api.nvim_get_option_value("winminheight", { scope = "global" }),
        line_numbers = vim.api.nvim_get_option_value("number", { scope = "global" }),
        mode = "topline",
        on_attach = function(buf)
          local filetype = vim.api.nvim_get_option_value("filetype", { buf = buf })

          if filetype == "" or filetype == "netrw" then return false end

          if
            vim.tbl_contains(
              { "help", "loclist", "nofile", "prompt", "quickfix", "terminal" },
              vim.api.nvim_get_option_value("buftype", { buf = buf })
            )
          then
            return false
          end
        end,
      })
    end,
  },
  {
    "danymat/neogen",
    dependencies = { "nvim-treesitter/nvim-treesitter", "L3MON4D3/LuaSnip" },
    cmd = "Neogen",
    config = function() require("neogen").setup({ snippet_engine = "luasnip" }) end,
  },
}
