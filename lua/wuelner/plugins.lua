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
  use("wbthomason/packer.nvim")
  use("lewis6991/impatient.nvim")

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
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    after = "human.vim",
    ft = "markdown",
  })

  -- Git.
  use({
    "tpope/vim-fugitive",
    after = "human.vim",
  })
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
            after = { "fern.vim", "nerdfont.vim" },
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
        event = "InsertEnter",
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
    after = "nvim-ts-context-commentstring",
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
        after = "nvim-cmp",
        module = "luasnip",
        requires = {
          "rafamadriz/friendly-snippets",
          {
            "saadparwaiz1/cmp_luasnip",
            after = "LuaSnip",
            event = "InsertEnter",
          },
        },
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
        end,
      },
      {
        "tzachar/cmp-tabnine",
        run = "./install.sh",
        after = "nvim-cmp",
        event = "InsertEnter",
        config = function()
          require("wuelner.settings.tabnine").config()
        end,
      },
      { "hrsh7th/cmp-buffer", module = "cmp_buffer" },
    },
    config = function()
      require("wuelner.settings.cmp").config()
    end,
  })
  use({
    "windwp/nvim-autopairs",
    after = "nvim-cmp",
    event = "InsertEnter",
    config = function()
      require("wuelner.settings.autopairs").config()
    end,
  })

  -- LSP.
  use({
    "williamboman/mason.nvim",
    requires = {
      "williamboman/mason-lspconfig.nvim",
      module = "mason-lspconfig",
    },
    config = function()
      require("mason").setup()
    end,
  })
  use({
    "neovim/nvim-lspconfig",
    after = { "mason.nvim", "nvim-cmp" },
    requires = {
      {
        "stevearc/aerial.nvim",
        after = "nvim-lspconfig",
        config = function()
          require("wuelner.settings.aerial").config()
        end,
      },
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
    "RRethy/vim-illuminate",
    after = "nvim-lspconfig",
    config = function()
      require("wuelner.settings.illuminate").config()
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
    config = function()
      require("wuelner.settings.emmet").config()
    end,
  })
  use({
    "matze/vim-move",
    after = "vim-sleuth",
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
    after = "human.vim",
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
    after = "human.vim",
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
      "anuvyklack/middleclass",
      "anuvyklack/animation.nvim",
    },
    config = function()
      require("wuelner.settings.windows").config()
    end,
  })
  use({
    "luukvbaal/stabilize.nvim",
    after = "windows.vim",
    disable = vim.version().minor >= 9 and true or false,
    config = function()
      require("stabilize").setup({
        ignore = { buftype = nil, filetype = nil },
      })
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
    after = "human.vim",
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
    after = "bufresize.nvim",
    cmd = "NERDTermToggle",
    keys = { { "n", "<leader>tt" } },
    config = function()
      require("wuelner.settings.nerdterm").config()
    end,
  })

  -- Telescope.
  use({
    "FeiyouG/command_center.nvim",
    keys = {
      { "n", "<C-Bslash>" },
      { "n", "<leader>ff" },
      { "n", "<leader>hf" },
      { "n", "<leader>mf" },
      { "n", "<leader>of" },
      { "n", "<leader>wf" },
    },
    requires = {
      "nvim-telescope/telescope.nvim",
      tag = "0.1.x",
      after = "command_center.nvim",
      requires = {
        { "nvim-lua/plenary.nvim", module = "plenary" },
        {
          "nvim-telescope/telescope-fzf-native.nvim",
          run = "make",
          module = "telescope._extensions.fzf",
        },
      },
      config = function()
        require("wuelner.settings.telescope").config()
      end,
    },
    config = function()
      require("wuelner.settings.command-center").config()
    end,
  })

  if packer_bootstrap then
    packer.sync()
  end
end)
