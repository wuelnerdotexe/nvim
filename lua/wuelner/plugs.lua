local vim_fn = vim.fn
local ensure_packer = function()
  local install_path = vim_fn.stdpath("data")
    .. "/site/pack/packer/start/packer.nvim"

  if vim_fn.empty(vim_fn.glob(install_path)) > 0 then
    vim_fn.system({
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

local packer = require("packer")

packer.init({ display = { prompt_border = "single" }, autoremove = true })

return packer.startup(function(use)
  -- Dependencies.
  use("wbthomason/packer.nvim")
  use("lewis6991/impatient.nvim")
  use({
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  })

  -- Options.
  use({
    "wuelnerdotexe/human.vim",
    setup = function()
      require("wuelner.settings.human").setup()
    end,
    config = function()
      require("wuelner.settings.human").config()
    end,
  })

  -- Development.
  use({
    "mfussenegger/nvim-dap",
    keys = { { "n", "<F9>" }, { "n", "<F5>" } },
    requires = { "rcarriga/nvim-dap-ui", module = "dapui" },
    config = function()
      require("wuelner.settings.dap").config()
    end,
  })
  use({
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    ft = "markdown",
  })

  -- Git.
  use({
    "lewis6991/gitsigns.nvim",
    after = "human.vim",
    config = function()
      require("wuelner.settings.gitsigns").config()
    end,
  })

  -- File browser.
  use({
    "lambdalisue/fern.vim",
    after = "human.vim",
    requires = {
      { "lambdalisue/fern-hijack.vim", after = "fern.vim" },
      { "lambdalisue/fern-git-status.vim", after = "fern.vim" },
      {
        "lambdalisue/nerdfont.vim",
        after = "fern.vim",
        requires = {
          {
            "lambdalisue/fern-renderer-nerdfont.vim",
            after = "nerdfont.vim",
          },
          { "lambdalisue/glyph-palette.vim", after = "nerdfont.vim" },
        },
      },
    },
    setup = function()
      require("wuelner.settings.fern").setup()
    end,
    config = function()
      require("wuelner.settings.fern").config()
    end,
  })

  -- Tree-sitter.
  use({
    "nvim-treesitter/nvim-treesitter",
    after = "human.vim",
    run = ":TSUpdate",
    requires = {
      { "p00f/nvim-ts-rainbow", after = "nvim-treesitter" },
      {
        "JoosepAlviste/nvim-ts-context-commentstring",
        after = "nvim-treesitter",
      },
      {
        "windwp/nvim-ts-autotag",
        after = "nvim-treesitter",
      },
    },
    config = function()
      require("wuelner.settings.treesitter").config()
    end,
  })
  use({
    "andymass/vim-matchup",
    after = "nvim-treesitter",
    setup = function()
      require("wuelner.settings.matchup").setup()
    end,
  })
  use({
    "numToStr/Comment.nvim",
    keys = { { "n", "gc" }, { "v", "gc" } },
    config = function()
      require("wuelner.settings.comment").config()
    end,
  })

  -- Indent.
  use({
    "tpope/vim-sleuth",
    after = "nvim-treesitter",
    setup = function()
      require("wuelner.settings.sleuth").setup()
    end,
  })
  use({
    "lukas-reineke/indent-blankline.nvim",
    after = "vim-sleuth",
    config = function()
      require("wuelner.settings.indent-blankline").config()
    end,
  })

  -- Autocomplete.
  use({
    "hrsh7th/nvim-cmp",
    after = "vim-sleuth",
    requires = {
      { "onsails/lspkind.nvim", module = "lspkind" },
      { "hrsh7th/cmp-nvim-lsp", module = "cmp_nvim_lsp" },
      {
        "L3MON4D3/LuaSnip",
        requires = {
          { "rafamadriz/friendly-snippets", module = "luasnip" },
          { "saadparwaiz1/cmp_luasnip", event = "InsertEnter" },
        },
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
        end,
      },
      {
        "tzachar/cmp-tabnine",
        run = "./install.sh",
        event = "InsertEnter",
        config = function()
          require("wuelner.settings.tabnine").config()
        end,
      },
      { "hrsh7th/cmp-buffer", module = "cmp_buffer" },
      { "rcarriga/cmp-dap", module = "cmp_dap" },
    },
    config = function()
      require("wuelner.settings.cmp").config()
    end,
  })
  use({
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("wuelner.settings.autopairs").config()
    end,
  })

  -- LSP.
  use({
    "neovim/nvim-lspconfig",
    after = { "mason.nvim", "nvim-cmp" },
    requires = {
      "williamboman/mason-lspconfig.nvim",
      module = "mason-lspconfig",
    },
    config = function()
      require("wuelner.settings.lspconfig").config()
    end,
  })
  use({
    "jose-elias-alvarez/null-ls.nvim",
    after = "nvim-lspconfig",
    requires = { "nvim-lua/plenary.nvim", module = "plenary" },
    config = function()
      require("wuelner.settings.null-ls").config()
    end,
  })
  use({
    "kosayoda/nvim-lightbulb",
    after = { "nvim-lspconfig", "null-ls.nvim" },
    config = function()
      require("wuelner.settings.lightbulb").config()
    end,
  })
  use({
    "RRethy/vim-illuminate",
    after = "nvim-lspconfig",
    config = function()
      require("wuelner.settings.illuminate").config()
    end,
  })
  use({
    "stevearc/aerial.nvim",
    after = "nvim-lspconfig",
    config = function()
      require("wuelner.settings.aerial").config()
    end,
  })
  use({
    "NvChad/nvim-colorizer.lua",
    after = "nvim-lspconfig",
    config = function()
      require("wuelner.settings.colorizer").config()
    end,
  })

  -- Typing.
  use({
    "mattn/emmet-vim",
    after = "vim-sleuth",
    cmd = "EmmetInstall",
    setup = function()
      require("wuelner.settings.emmet").setup()
    end,
  })
  use({
    "matze/vim-move",
    keys = { "<A-Left>", "<A-Down>", "<A-Up>", "<A-Right>" },
    setup = function()
      require("wuelner.settings.move").setup()
    end,
    config = function()
      require("wuelner.settings.move").config()
    end,
  })
  use({
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
    setup = function()
      require("wuelner.settings.visual-multi").setup()
    end,
  })

  -- Theme.
  use({
    "wuelnerdotexe/vim-enfocado",
    branch = "development",
    after = "human.vim",
    setup = function()
      require("wuelner.settings.enfocado").setup()
    end,
    config = function()
      require("wuelner.settings.enfocado").config()
    end,
  })

  -- Statusline.
  use({
    "feline-nvim/feline.nvim",
    after = { "human.vim", "aerial.nvim", "vim-enfocado" },
    config = function()
      require("wuelner.settings.feline").config()
    end,
  })
  use({
    "akinsho/bufferline.nvim",
    tag = "v2.*",
    after = { "human.vim", "fern.vim", "aerial.nvim" },
    requires = {
      "tiagovla/scope.nvim",
      config = function()
        require("scope").setup()
      end,
    },
    config = function()
      require("wuelner.settings.bufferline").config()
    end,
  })

  -- Improvements.
  use({
    "wuelnerdotexe/cinnamon.nvim",
    after = "human.vim",
    config = function()
      require("wuelner.settings.cinnamon").config()
    end,
  })
  use({
    "anuvyklack/windows.nvim",
    after = "human.vim",
    requires = {
      { "anuvyklack/middleclass", module = "middleclass" },
      { "anuvyklack/animation.nvim", module = "animation" },
    },
    config = function()
      require("wuelner.settings.windows").config()
    end,
  })
  use({
    "kwkarlwang/bufresize.nvim",
    after = "windows.nvim",
    config = function()
      require("wuelner.settings.bufresize").config()
    end,
  })
  use({
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
    config = function()
      require("wuelner.settings.tmux").config()
    end,
  })
  use({
    "wuelnerdotexe/nerdterm",
    cmd = "NERDTermToggle",
    keys = { { "n", "<leader>tt" } },
    config = function()
      require("wuelner.settings.nerdterm").config()
    end,
  })

  -- Telescope.
  use({
    "nvim-telescope/telescope.nvim",
    tag = "0.1.x",
    keys = {
      { "n", "<C-Bslash>" },
      { "n", "<leader>ff" },
      { "n", "<leader>hf" },
      { "n", "<leader>mf" },
      { "n", "<leader>of" },
      { "n", "<leader>wf" },
    },
    requires = {
      { "nvim-lua/plenary.nvim", module = "plenary" },
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        run = "make",
        module = "telescope._extensions.fzf",
      },
      {
        "FeiyouG/command_center.nvim",
        module = "command_center",
        config = function()
          require("wuelner.settings.command_center").config()
        end,
      },
    },
    config = function()
      require("wuelner.settings.telescope").config()
    end,
  })

  if packer_bootstrap then
    packer.sync()
  end
end)
