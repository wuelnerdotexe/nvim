local ensure_packer = function()
  local install_path = vim.fn.stdpath("data")
    .. "/site/pack/packer/start/packer.nvim"

  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({
      "git",
      "clone",
      "--depth",
      "1",
      "https://github.com/wbthomason/packer.nvim",
      install_path,
    })

    vim.cmd("packadd packer.nvim")

    return true
  end

  return false
end

local packer_bootstrap = ensure_packer()

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

return require("packer").startup(function(use)
  use({
    "wbthomason/packer.nvim",
    "lewis6991/impatient.nvim",

    -- Dependencies.
    { "nvim-lua/plenary.nvim", module = "plenary" },
    {
      "williamboman/mason.nvim",
      requires = {
        { "jayp0521/mason-nvim-dap.nvim", module = "mason-nvim-dap" },
        { "jayp0521/mason-null-ls.nvim", module = "mason-null-ls" },
        { "williamboman/mason-lspconfig.nvim", module = "mason-lspconfig" },
      },
      config = "require('wuelner.settings.mason').config()",
    },

    -- Options.
    {
      "wuelnerdotexe/human.vim",
      setup = "require('wuelner.settings.human').setup()",
      config = "require('wuelner.settings.human').config()",
    },

    -- Development.
    {
      "mfussenegger/nvim-dap",
      keys = { { "n", "<F9>" }, { "n", "<F5>" } },
      requires = { "rcarriga/nvim-dap-ui", module = "dapui" },
      config = "require('wuelner.settings.dap').config()",
    },
    {
      "iamcco/markdown-preview.nvim",
      run = "cd app && npm install",
      ft = "markdown",
      setup = "require('wuelner.settings.markdown-preview').setup()",
    },

    -- Git.
    {
      "lewis6991/gitsigns.nvim",
      after = "human.vim",
      config = "require('wuelner.settings.gitsigns').config()",
    },

    -- Folders explorer.
    {
      "lambdalisue/fern.vim",
      after = "human.vim",
      requires = {
        "lambdalisue/fern-hijack.vim",
        "lambdalisue/fern-git-status.vim",
        {
          "lambdalisue/fern-renderer-nerdfont.vim",
          requires = {
            "lambdalisue/nerdfont.vim",
            "lambdalisue/glyph-palette.vim",
          },
        },
      },
      setup = "require('wuelner.settings.fern').setup()",
      config = "require('wuelner.settings.fern').config()",
    },

    -- Tree-sitter.
    {
      "nvim-treesitter/nvim-treesitter",
      after = "human.vim",
      run = ":TSUpdate",
      requires = {
        {
          "JoosepAlviste/nvim-ts-context-commentstring",
          after = "nvim-treesitter",
        },
        { "p00f/nvim-ts-rainbow", after = "nvim-treesitter" },
        { "windwp/nvim-ts-autotag", after = "nvim-treesitter" },
      },
      config = "require('wuelner.settings.treesitter').config()",
    },
    {
      "andymass/vim-matchup",
      after = "nvim-treesitter",
      setup = "require('wuelner.settings.matchup').setup()",
    },
    {
      "numToStr/Comment.nvim",
      keys = { { "n", "gc" }, { "v", "gc" } },
      config = "require('wuelner.settings.comment').config()",
    },

    -- Indent.
    {
      "tpope/vim-sleuth",
      after = "nvim-treesitter",
      setup = "require('wuelner.settings.sleuth').setup()",
    },
    {
      "lukas-reineke/indent-blankline.nvim",
      after = "vim-sleuth",
      config = "require('wuelner.settings.indent-blankline').config()",
    },

    -- Autocomplete.
    {
      "hrsh7th/nvim-cmp",
      after = "vim-sleuth",
      requires = {
        { "hrsh7th/cmp-buffer", module = "cmp_buffer" },
        { "hrsh7th/cmp-nvim-lsp", module = "cmp_nvim_lsp" },
        {
          "saadparwaiz1/cmp_luasnip",
          event = "InsertEnter",
          requires = {
            "L3MON4D3/LuaSnip",
            requires = {
              "rafamadriz/friendly-snippets",
              module = "luasnip.loaders.from_vscode",
            },
            config = "require('luasnip.loaders.from_vscode').lazy_load()",
          },
        },
        { "hrsh7th/cmp-path", event = "InsertEnter" },
        {
          "tzachar/cmp-tabnine",
          run = "./install.sh",
          event = "InsertEnter",
          config = "vim.schedule(function()"
            .. "require('wuelner.settings.tabnine').config()"
            .. "end)",
        },
        { "rcarriga/cmp-dap", module = "cmp_dap" },
      },
      config = "require('wuelner.settings.cmp').config()",
    },
    {
      "windwp/nvim-autopairs",
      event = "InsertEnter",
      config = "require('wuelner.settings.autopairs').config()",
    },

    -- LSP.
    {
      "jose-elias-alvarez/null-ls.nvim",
      after = "mason.nvim",
      config = "require('wuelner.settings.null-ls').config()",
    },
    {
      "neovim/nvim-lspconfig",
      after = { "mason.nvim", "nvim-cmp" },
      requires = {
        { "b0o/schemastore.nvim", module = "schemastore" },
        { "kosayoda/nvim-lightbulb", module = "nvim-lightbulb" },
      },
      config = "require('wuelner.settings.lspconfig').config()",
    },
    {
      "RRethy/vim-illuminate",
      after = "nvim-lspconfig",
      config = "require('wuelner.settings.illuminate').config()",
    },
    {
      "stevearc/aerial.nvim",
      after = "nvim-lspconfig",
      config = "require('wuelner.settings.aerial').config()",
    },
    {
      "NvChad/nvim-colorizer.lua",
      after = "nvim-lspconfig",
      config = "require('wuelner.settings.colorizer').config()",
    },

    -- Typing.
    {
      "mattn/emmet-vim",
      cmd = "EmmetInstall",
      setup = "require('wuelner.settings.emmet').setup()",
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
      setup = "require('wuelner.settings.visual-multi').setup()",
    },

    -- Theme.
    {
      "wuelnerdotexe/vim-enfocado",
      setup = "require('wuelner.settings.enfocado').setup()",
      config = "require('wuelner.settings.enfocado').config()",
    },

    -- Statusline.
    {
      "feline-nvim/feline.nvim",
      after = { "aerial.nvim", "vim-enfocado" },
      config = "require('wuelner.settings.feline').config()",
    },
    {
      "akinsho/bufferline.nvim",
      after = "human.vim",
      config = "require('wuelner.settings.bufferline').config()",
    },

    -- Improvements.
    {
      "folke/noice.nvim",
      disable = vim.version().minor < 9,
      cond = "vim.fn.exists('g:neovide') ~= 1",
      after = "nvim-lspconfig",
      requires = {
        { "MunifTanjim/nui.nvim", module_pattern = "nui.*" },
        { "rcarriga/nvim-notify", module = "notify" },
      },
      config = "require('wuelner.settings.noice').config()",
    },
    {
      "gen740/SmoothCursor.nvim",
      after = "human.vim",
      config = "require('wuelner.settings.smoothcursor').config()",
    },
    {
      "anuvyklack/windows.nvim",
      keys = { { "n", "<C-w>" }, { "x", "<C-w>" } },
      requires = {
        { "anuvyklack/middleclass", module = "middleclass" },
        { "anuvyklack/animation.nvim", module = "animation" },
      },
      config = "require('wuelner.settings.windows').config()",
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
      config = "require('wuelner.settings.tmux').config()",
    },
    {
      "wuelnerdotexe/nerdterm",
      keys = { { "n", "<leader>tt" } },
      config = "require('wuelner.settings.nerdterm').config()",
    },

    -- Telescope.
    {
      "nvim-telescope/telescope.nvim",
      keys = {
        { "n", "<leader>ff" },
        { "n", "<leader>hf" },
        { "n", "<leader>mf" },
        { "n", "<leader>of" },
        { "n", "<leader>wf" },
      },
      requires = {
        "nvim-telescope/telescope-fzf-native.nvim",
        run = "make",
        module = "telescope._extensions.fzf",
      },
      config = "require('wuelner.settings.telescope').config()",
    },

    -- Presence.
    {
      "andweeb/presence.nvim",
      config = "require('wuelner.settings.presence').config()",
    },
  })

  if packer_bootstrap then
    require("packer").sync()
  end
end)
