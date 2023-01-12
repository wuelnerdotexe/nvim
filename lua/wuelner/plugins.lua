require("packer").init({
  max_jobs = 3,
  display = {
    prompt_border = "rounded",
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
  autoremove = true,
})

local VeryLazy = { "BufNewFile", "BufRead" }

return require("packer").startup(function(use)
  use({
    "wbthomason/packer.nvim",
    "lewis6991/impatient.nvim",
    { "nvim-lua/plenary.nvim", module = "plenary" },
    {
      "williamboman/mason.nvim",
      requires = {
        { "jayp0521/mason-nvim-dap.nvim", module = "mason-nvim-dap" },
        { "jayp0521/mason-null-ls.nvim", module = "mason-null-ls" },
        { "williamboman/mason-lspconfig.nvim", module = "mason-lspconfig" },
      },
      config = "require('wuelner.settings.mason')",
    },
    {
      "wuelnerdotexe/human.vim",
      setup = "require('wuelner.settings.human').setup()",
      config = "require('wuelner.settings.human').config()",
    },
    {
      "sheerun/vim-polyglot",
      setup = "require('wuelner.settings.polyglot').setup()",
      config = "require('wuelner.settings.polyglot').config()",
    },
    {
      "mfussenegger/nvim-dap",
      keys = { { "n", "<F9>" }, { "n", "<F5>" } },
      requires = { "rcarriga/nvim-dap-ui", module = "dapui" },
      config = "require('wuelner.settings.dap')",
    },
    {
      "iamcco/markdown-preview.nvim",
      run = "cd app && npm install",
      ft = "markdown",
      setup = "require('wuelner.settings.markdown-preview')",
    },
    {
      "lewis6991/gitsigns.nvim",
      event = VeryLazy,
      config = "require('wuelner.settings.gitsigns')",
    },
    {
      "lambdalisue/fern.vim",
      after = "human.vim",
      requires = {
        "lambdalisue/fern-hijack.vim",
        "lambdalisue/fern-git-status.vim",
        {
          "lambdalisue/fern-renderer-nerdfont.vim",
          requires = { "lambdalisue/nerdfont.vim", "lambdalisue/glyph-palette.vim" },
        },
      },
      setup = "require('wuelner.settings.fern').setup()",
      config = "require('wuelner.settings.fern').config()",
    },
    {
      "gnikdroy/projections.nvim",
      after = "fern.vim",
      config = "require('wuelner.settings.projections')",
    },
    {
      "nvim-treesitter/nvim-treesitter",
      after = "vim-polyglot",
      run = ":TSUpdate",
      requires = {
        { "JoosepAlviste/nvim-ts-context-commentstring", after = "nvim-treesitter" },
        { "mrjones2014/nvim-ts-rainbow", after = "nvim-treesitter" },
        { "windwp/nvim-ts-autotag", after = "nvim-treesitter" },
      },
      config = "require('wuelner.settings.treesitter')",
    },
    {
      "andymass/vim-matchup",
      event = VeryLazy,
      setup = "require('wuelner.settings.matchup')",
    },
    {
      "numToStr/Comment.nvim",
      keys = { { "n", "gc" }, { "v", "gc" } },
      config = "require('wuelner.settings.comment')",
    },
    {
      "tpope/vim-sleuth",
      after = "nvim-treesitter",
      setup = "require('wuelner.settings.sleuth')",
    },
    {
      "lukas-reineke/indent-blankline.nvim",
      event = VeryLazy,
      config = "require('wuelner.settings.indent-blankline')",
    },
    {
      "hrsh7th/nvim-cmp",
      after = "vim-sleuth",
      requires = {
        { "hrsh7th/cmp-buffer", module = "cmp_buffer" },
        { "hrsh7th/cmp-nvim-lsp", module = "cmp_nvim_lsp" },
        { "hrsh7th/cmp-path", event = "InsertEnter" },
        {
          "saadparwaiz1/cmp_luasnip",
          event = "InsertEnter",
          requires = {
            "L3MON4D3/LuaSnip",
            event = VeryLazy,
            requires = {
              "rafamadriz/friendly-snippets",
              after = "LuaSnip",
              event = "InsertEnter",
              config = "require('luasnip.loaders.from_vscode').lazy_load()",
            },
          },
        },
        { "jackieaskins/cmp-emmet", run = "npm run release" },
        {
          "tzachar/cmp-tabnine",
          run = "./install.sh",
          event = "InsertEnter",
          config = "vim.schedule(function() require('wuelner.settings.tabnine') end)",
        },
        { "rcarriga/cmp-dap", module = "cmp_dap" },
      },
      config = "require('wuelner.settings.cmp')",
    },
    {
      "windwp/nvim-autopairs",
      event = "InsertEnter",
      config = "require('wuelner.settings.autopairs')",
    },
    {
      "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
      event = "UIEnter",
      config = "require('wuelner.settings.lsp_lines')",
    },
    {
      "neovim/nvim-lspconfig",
      after = { "mason.nvim", "nvim-cmp" },
      requires = {
        { "b0o/schemastore.nvim", module = "schemastore" },
        { "kosayoda/nvim-lightbulb", module = "nvim-lightbulb" },
      },
      config = "require('wuelner.settings.lspconfig')",
    },
    {
      "jose-elias-alvarez/null-ls.nvim",
      event = VeryLazy,
      config = "require('wuelner.settings.null-ls')",
    },
    {
      "RRethy/vim-illuminate",
      event = VeryLazy,
      config = "require('wuelner.settings.illuminate')",
    },
    {
      "stevearc/aerial.nvim",
      event = VeryLazy,
      config = "require('wuelner.settings.aerial')",
    },
    {
      "NvChad/nvim-colorizer.lua",
      event = VeryLazy,
      config = "require('wuelner.settings.colorizer')",
    },
    {
      "matze/vim-move",
      keys = { "<A-Left>", "<A-Down>", "<A-Up>", "<A-Right>" },
      setup = "require('wuelner.settings.move').setup()",
      config = "require('wuelner.settings.move').config()",
    },
    {
      "mg979/vim-visual-multi",
      keys = {
        { "n", "<C-n>" },
        { "x", "<C-n>" },
        { "n", "<C-Up>" },
        { "n", "<C-Down>" },
        { "n", "<S-Left>" },
        { "n", "<S-Right>" },
        { "n", "<C-LeftMouse>" },
        { "n", "<C-RightMouse>" },
        { "n", "<M-C-RightMouse>" },
        { "n", "<Bslash><Bslash>" },
        { "x", "<Bslash><Bslash>" },
      },
      setup = "require('wuelner.settings.visual-multi')",
    },
    {
      "wuelnerdotexe/vim-enfocado",
      setup = "require('wuelner.settings.enfocado').setup()",
      config = "require('wuelner.settings.enfocado').config()",
    },
    {
      "feline-nvim/feline.nvim",
      event = "UIEnter",
      config = "require('wuelner.settings.feline')",
    },
    {
      "akinsho/bufferline.nvim",
      event = "UIEnter",
      requires = "roobert/bufferline-cycle-windowless.nvim",
      config = "require('wuelner.settings.bufferline')",
    },
    {
      "petertriho/nvim-scrollbar",
      event = "UIEnter",
      config = "require('wuelner.settings.scrollbar')",
    },
    {
      "folke/noice.nvim",
      disable = vim.version().minor < 9,
      cond = "vim.api.nvim_call_function('exists', { 'g:neovide' }) ~= 1",
      event = "UIEnter",
      requires = {
        { "MunifTanjim/nui.nvim", module_pattern = "nui.*" },
        { "rcarriga/nvim-notify", module = "notify" },
      },
      config = "require('wuelner.settings.noice')",
    },
    {
      'stevearc/dressing.nvim',
      event = "UIEnter",
      config = "require('wuelner.settings.dressing')",
    },
    {
      "gen740/SmoothCursor.nvim",
      event = VeryLazy,
      config = "require('wuelner.settings.smoothcursor')",
    },
    {
      "echasnovski/mini.animate",
      event = "UIEnter",
      config = "require('wuelner.settings.animate')",
    },
    {
      "aserowy/tmux.nvim",
      keys = {
        { "n", "<C-h>" },
        { "n", "<C-j>" },
        { "n", "<C-k>" },
        { "n", "<C-l>" },
        { "n", "<A-h>" },
        { "n", "<A-j>" },
        { "n", "<A-k>" },
        { "n", "<A-l>" },
      },
      config = "require('wuelner.settings.tmux')",
    },
    {
      "wuelnerdotexe/nerdterm",
      keys = { { "n", "<leader>tt" } },
      config = "require('wuelner.settings.nerdterm')",
    },
    {
      "nvim-telescope/telescope.nvim",
      keys = {
        { "n", "<leader>ff" },
        { "n", "<leader>mf" },
        { "n", "<leader>of" },
        { "n", "<leader>wf" },
        { "n", "<leader>pf" },
      },
      requires = {
        "nvim-telescope/telescope-fzf-native.nvim",
        run = "make",
        module = "telescope._extensions.fzf",
      },
      config = "require('wuelner.settings.telescope')",
    },
    {
      "andweeb/presence.nvim",
      event = VeryLazy,
      config = "require('wuelner.settings.presence')",
    },
  })
end)
