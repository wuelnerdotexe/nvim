local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({
      'git', 'clone', '--depth', '1',
      'https://github.com/wbthomason/packer.nvim',
      install_path
    })

    vim.cmd [[packadd packer.nvim]]

    return true
  end

  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'lewis6991/impatient.nvim'

  -- Options.
  use {
    'wuelnerdotexe/human.vim',
    config = function() require('wuelner.settings.human').config() end
  }

  -- Workflow.
  use {
    'glepnir/dashboard-nvim',
    config = function() require('wuelner.settings.dashboard').config() end
  }
  use {
    'wuelnerdotexe/nerdterm',
    keys = { {'n', '<leader>tt' } },
    config = function() require('wuelner.settings.nerdterm').config() end
  }
  use {
    'iamcco/markdown-preview.nvim',
    ft = 'markdown',
    run = 'cd app && npm install'
  }

  -- File managers.
  use {
    'junegunn/fzf',
    cmd = 'FZF',
    run = function() vim.fn['fzf#install']() end,
    setup = function() require('wuelner.settings.fzf').setup() end
  }
  use {
    'lambdalisue/fern.vim',
    requires = {
      'lambdalisue/fern-hijack.vim',
      'lambdalisue/fern-git-status.vim',
      {
        'lambdalisue/fern-renderer-nerdfont.vim',
        requires = {
          'lambdalisue/nerdfont.vim',
          'lambdalisue/glyph-palette.vim'
        }
      }
    },
    setup = function() require('wuelner.settings.fern').setup() end,
    config = function() require('wuelner.settings.fern').config() end
  }

  -- Git.
  use 'tpope/vim-fugitive'
  use {
    'lewis6991/gitsigns.nvim',
    config = function() require('wuelner.settings.gitsigns').config() end
  }

  -- LSP.
  use {
    'williamboman/mason.nvim',
    config = function() require('mason').setup() end
  }
  use {
    'neovim/nvim-lspconfig',
    requires = 'williamboman/mason-lspconfig.nvim',
    config = function() require('wuelner.settings.lspconfig').config() end
  }
  use {
    'jose-elias-alvarez/null-ls.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function() require('wuelner.settings.null-ls').config() end
  }

  -- Treesitter.
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    requires = {
      'JoosepAlviste/nvim-ts-context-commentstring',
      'p00f/nvim-ts-rainbow',
      { 'windwp/nvim-ts-autotag', event = 'InsertEnter' }
    },
    config = function() require('wuelner.settings.treesitter').config() end
  }
  use {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function() require('wuelner.settings.autopairs').config() end
  }
  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('wuelner.settings.indent-blankline').config()
    end
  }

  -- Syntax.
  use {
    'tpope/vim-sleuth',
    setup = function() require('wuelner.settings.sleuth').setup() end
  }
  use {
    'tpope/vim-commentary',
    keys = { { 'v','gc' }, { 'n','gcc' } }
  }
  use {
    'andymass/vim-matchup',
    setup = function() require('wuelner.settings.matchup').setup() end
  }
  use {
    'RRethy/vim-illuminate',
    config = function() require('wuelner.settings.illuminate').config() end
  }

  -- Autocomplete.
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'onsails/lspkind.nvim',
      'hrsh7th/cmp-nvim-lsp',
      {
        'L3MON4D3/LuaSnip',
        requires = 'rafamadriz/friendly-snippets',
        config = function()
          require('luasnip.loaders.from_vscode').lazy_load()
        end
      },
      { 'saadparwaiz1/cmp_luasnip', event = 'InsertEnter' },
      { 'ray-x/cmp-treesitter', event = 'InsertEnter' },
      { 'hrsh7th/cmp-buffer', event = 'InsertEnter' },
      { 'tzachar/cmp-tabnine', event = 'InsertEnter', run = './install.sh' }
    },
    config = function() require('wuelner.settings.cmp').config() end
  }

  -- Typing.
  use 'chaoren/vim-wordmotion'
  use {
    'mattn/emmet-vim',
    cmd = 'EmmetInstall',
    setup = function() require('wuelner.settings.emmet').setup() end
  }
  use { 'matze/vim-move', keys = { '<A-h>', '<A-j>', '<A-k>', '<A-l>' } }
  use {
    'mg979/vim-visual-multi',
    keys = { { 'n', '<C-n>' }, { 'n', '<C-Down>' }, { 'n', '<C-Up>' } }
  }

  -- Theme.
  use {
    'wuelnerdotexe/vim-enfocado',
    branch = 'development',
    setup = function() require('wuelner.settings.enfocado').setup() end,
    config = function() require('wuelner.settings.enfocado').config() end
  }

  -- Statusline.
  use({
    'glepnir/galaxyline.nvim',
    branch = 'main',
    config = function() require('wuelner.settings.galaxyline').config() end
  })
  use {
    'akinsho/bufferline.nvim',
    tag = "v2.*",
    config = function() require('wuelner.settings.bufferline').config() end
  }

  -- Tools.
  use {
    'simeji/winresizer',
    keys = { { 'n', '<C-e>' } },
    setup = function() require('wuelner.settings.winresize').setup() end
  }
  use {
    'antoinemadec/FixCursorHold.nvim',
    setup = function() vim.g.cursorhold_updatetime = 100 end
  }

  if packer_bootstrap then
    require('packer').sync()
  end
end)

