local vim_fn = vim.fn
local ensure_packer = function()
  local install_path = vim_fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

  if vim_fn.empty(vim_fn.glob(install_path)) > 0
  then
    vim_fn.system({
      'git', 'clone', '--depth', '1',
      'https://github.com/wbthomason/packer.nvim',
      install_path
    })

    vim.cmd('packadd packer.nvim')

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
    setup = 'require("wuelner.settings.human").setup()',
    config = 'require("wuelner.settings.human").config()'
  }
  use {
    'antoinemadec/FixCursorHold.nvim',
    after = 'human.vim',
    setup = 'vim.g.cursorhold_updatetime = 40'
  }

  -- Development.
  use {
    'wuelnerdotexe/nerdterm',
    keys = { { 'n', '<leader>tt' } },
    config = 'require("wuelner.settings.nerdterm").config()'
  }
  use {
    'iamcco/markdown-preview.nvim',
    after = 'FixCursorHold.nvim',
    run = 'cd app && npm install',
    ft = 'markdown'
  }

  -- File managers.
  use {
    'junegunn/fzf',
    run = function() vim_fn['fzf#install']() end,
    after = 'FixCursorHold.nvim',
    keys = { { 'n', '<leader>ff' } },
    setup = 'require("wuelner.settings.fzf").setup()',
    config = 'require("wuelner.settings.fzf").config()'
  }
  use {
    'lambdalisue/fern.vim',
    after = 'FixCursorHold.nvim',
    requires = {
      { 'lambdalisue/fern-hijack.vim', after = 'fern.vim' },
      { 'lambdalisue/fern-git-status.vim', after = 'fern.vim' },
      {
        'lambdalisue/nerdfont.vim',
        after = 'fern.vim',
        requires = {
          {
            'lambdalisue/fern-renderer-nerdfont.vim',
            after = { 'fern.vim', 'nerdfont.vim' }
          },
          { 'lambdalisue/glyph-palette.vim', after = 'nerdfont.vim' }
        }
      }
    },
    setup = 'require("wuelner.settings.fern").setup()',
    config = 'require("wuelner.settings.fern").config()'
  }

  -- Git.
  use {
    'tpope/vim-fugitive',
    after = 'FixCursorHold.nvim'
  }
  use {
    'lewis6991/gitsigns.nvim',
    after = 'FixCursorHold.nvim',
    config = 'require("wuelner.settings.gitsigns").config()'
  }

  -- Tree-sitter.
  use {
    'nvim-treesitter/nvim-treesitter',
    after = 'FixCursorHold.nvim',
    run = ':TSUpdate',
    requires = {
      { 'p00f/nvim-ts-rainbow', after = 'nvim-treesitter' },
      {
        'JoosepAlviste/nvim-ts-context-commentstring',
        after = 'nvim-treesitter'
      },
      {
        'windwp/nvim-ts-autotag',
        after = 'nvim-treesitter',
        event = 'InsertEnter'
      }
    },
    config = 'require("wuelner.settings.treesitter").config()'
  }
  use {
    'andymass/vim-matchup',
    after = 'nvim-treesitter',
    setup = 'require("wuelner.settings.matchup").setup()'
  }
  use {
    'numToStr/Comment.nvim',
    after = 'nvim-ts-context-commentstring',
    keys = { { 'n', 'gc' }, { 'v', 'gc' } },
    config = 'require("wuelner.settings.comment").config()'
  }

  -- Indent.
  use {
    'tpope/vim-sleuth',
    after = 'nvim-treesitter',
    setup = 'require("wuelner.settings.sleuth").setup()'
  }
  use {
    'lukas-reineke/indent-blankline.nvim',
    after = 'vim-sleuth',
    config = 'require("wuelner.settings.indent-blankline").config()'
  }

  -- Autocomplete.
  use {
    'hrsh7th/nvim-cmp',
    after = 'vim-sleuth',
    requires = {
      { 'onsails/lspkind.nvim', module = 'lspkind' },
      { 'hrsh7th/cmp-nvim-lsp', module = 'cmp_nvim_lsp' },
      {
        'L3MON4D3/LuaSnip',
        after = 'nvim-cmp',
        module = 'luasnip',
        requires = {
          'rafamadriz/friendly-snippets',
          {
            'saadparwaiz1/cmp_luasnip',
            after = 'LuaSnip',
            event = 'InsertEnter'
          }
        },
        config = 'require("luasnip.loaders.from_vscode").lazy_load()'
      },
      {
        'tzachar/cmp-tabnine',
        run = './install.sh',
        after = 'nvim-cmp',
        event = 'InsertEnter',
        config = 'require("wuelner.settings.tabnine").config()'
      },
      { 'hrsh7th/cmp-buffer', module = 'cmp_buffer' },
    },
    config = 'require("wuelner.settings.cmp").config()'
  }
  use {
    'windwp/nvim-autopairs',
    after = 'nvim-cmp',
    event = 'InsertEnter',
    config = 'require("wuelner.settings.autopairs").config()'
  }

  -- LSP.
  use {
    'williamboman/mason.nvim',
    requires = {
      'williamboman/mason-lspconfig.nvim',
      module = 'mason-lspconfig'
    },
    config = 'require("mason").setup()'
  }
  use {
    'neovim/nvim-lspconfig',
    after = { 'mason.nvim', 'nvim-cmp' },
    config = 'require("wuelner.settings.lspconfig").config()'
  }
  use {
    'jose-elias-alvarez/null-ls.nvim',
    after = 'nvim-lspconfig',
    requires = { 'nvim-lua/plenary.nvim', module = 'plenary' },
    config = 'require("wuelner.settings.null-ls").config()'
  }
  use {
    'RRethy/vim-illuminate',
    after = 'nvim-lspconfig',
    config = 'require("wuelner.settings.illuminate").config()'
  }
  use {
    'NvChad/nvim-colorizer.lua',
    after = 'nvim-lspconfig',
    config = 'require("wuelner.settings.colorizer").config()'
  }

  -- Typing.
  use {
    'mattn/emmet-vim',
    after = 'vim-sleuth',
    cmd = 'EmmetInstall',
    setup = 'require("wuelner.settings.emmet").setup()',
    config = 'require("wuelner.settings.emmet").config()'
  }
  use {
    'matze/vim-move',
    after = 'vim-sleuth',
    keys = { '<A-Left>', '<A-Down>', '<A-Up>', '<A-Right>' },
    setup = 'require("wuelner.settings.move").setup()',
    config = 'require("wuelner.settings.move").config()'
  }
  use {
    'mg979/vim-visual-multi',
    after = 'FixCursorHold.nvim',
    keys = {
      [[\\]], '<C-n>',
      { 'n', '<S-Left>' },
      { 'n', '<C-Down>' },
      { 'n', '<C-Up>' },
      { 'n', '<S-Right>' },
      { 'n', '<C-LeftMouse>' },
      { 'n', '<C-RightMouse>' },
      { 'n', '<M-C-RightMouse>' }
    },
    setup = 'require("wuelner.settings.visual-multi").setup()'
  }

  -- Theme.
  use {
    'wuelnerdotexe/vim-enfocado',
    branch = 'development',
    after = 'human.vim',
    setup = 'require("wuelner.settings.enfocado").setup()',
    config = 'require("wuelner.settings.enfocado").config()'
  }

  -- Statusline.
  use {
    'feline-nvim/feline.nvim',
    after = { 'FixCursorHold.nvim', 'vim-enfocado' },
    config = 'require("wuelner.settings.feline").config()'
  }
  use {
    'akinsho/bufferline.nvim',
    tag = 'v2.*',
    after = 'FixCursorHold.nvim',
    config = 'require("wuelner.settings.bufferline").config()'
  }

  -- Improvements.
  use {
    'declancm/cinnamon.nvim',
    after = 'human.vim',
    config = 'require("wuelner.settings.cinnamon").config()'
  }
  use {
    'luukvbaal/stabilize.nvim',
    after = 'human.vim',
    config = 'require("wuelner.settings.stabilize").config()'
  }
  use {
    'kwkarlwang/bufresize.nvim',
    after = 'stabilize.nvim',
    config = 'require("wuelner.settings.bufresize").config()'
  }
  use({
    'aserowy/tmux.nvim',
    after = 'human.vim',
    keys = {
      {'n', '<C-h>' }, {'n', '<C-j>' }, {'n', '<C-k>' }, {'n', '<C-l>' },
      {'n', '<A-h>' }, {'n', '<A-j>' }, {'n', '<A-k>' }, {'n', '<A-l>' }
    },
    config = 'require("wuelner.settings.tmux").config()'
  })

  if packer_bootstrap
  then
    require('packer').sync()
  end
end)
