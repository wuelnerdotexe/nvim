return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = require("wuelnerdotexe.plugin.config").open_file_event,
    config = function()
      local highlight_disable = {}
      local enable = { enable = true }

      require("nvim-treesitter.configs").setup({
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@conditional.outer",
              ["ic"] = "@conditional.inner",
              ["al"] = "@loop.outer",
              ["il"] = "@loop.inner",
            },
            selection_modes = {
              ["@function.outer"] = "v",
              ["@function.inner"] = "v",
              ["@conditional.outer"] = "v",
              ["@conditional.inner"] = "v",
              ["@loop.outer"] = "v",
              ["@loop.inner"] = "v",
            },
            include_surrounding_whitespace = true,
          },
          swap = {
            enable = true,
            swap_next = { ["<Tab>"] = "@parameter.inner" },
            swap_previous = { ["<S-Tab>"] = "@parameter.inner" },
          },
          move = enable,
          lsp_interop = { enable = true, peek_definition_code = { ["gD"] = "@*.*" } },
        },
        context_commentstring = { enable = true, enable_autocmd = false },
        ensure_installed = { "bash", "comment", "lua", "markdown", "markdown_inline", "regex", "vim" },
        sync_install = true,
        auto_install = true,
        highlight = {
          enable = true,
          disable = function(_, buf)
            if highlight_disable[buf] then
              return highlight_disable[buf]
            else
              local stats = vim.loop.fs_stat(vim.api.nvim_buf_get_name(buf))

              if stats and stats.size > 102400 then
                highlight_disable[buf] = true

                return highlight_disable[buf]
              end
            end
          end,
          additional_vim_regex_highlighting = false,
        },
        indent = enable,
        incremental_selection = {
          enable = true,
          keymaps = { init_selection = "<M-v>", node_incremental = "<C-a>", node_decremental = "<C-x>" },
        },
        rainbow = enable,
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = require("wuelnerdotexe.plugin.config").open_file_event,
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      local keymap_callback_repeat_last_move = {
        callback = function() require("nvim-treesitter.textobjects.repeatable_move").repeat_last_move() end,
      }

      vim.api.nvim_set_keymap("n", ";", "", keymap_callback_repeat_last_move)
      vim.api.nvim_set_keymap("x", ";", "", keymap_callback_repeat_last_move)
      vim.api.nvim_set_keymap("o", ";", "", keymap_callback_repeat_last_move)

      local keymap_callback_repeat_last_move_opposite = {
        callback = function() require("nvim-treesitter.textobjects.repeatable_move").repeat_last_move_opposite() end,
      }

      vim.api.nvim_set_keymap("n", ",", "", keymap_callback_repeat_last_move_opposite)
      vim.api.nvim_set_keymap("x", ",", "", keymap_callback_repeat_last_move_opposite)
      vim.api.nvim_set_keymap("o", ",", "", keymap_callback_repeat_last_move_opposite)

      local keymap_callback_builtin_f = {
        callback = function() require("nvim-treesitter.textobjects.repeatable_move").builtin_f() end,
      }

      vim.api.nvim_set_keymap("n", "f", "", keymap_callback_builtin_f)
      vim.api.nvim_set_keymap("x", "f", "", keymap_callback_builtin_f)
      vim.api.nvim_set_keymap("o", "f", "", keymap_callback_builtin_f)

      local keymap_callback_builtin_F = {
        callback = function() require("nvim-treesitter.textobjects.repeatable_move").builtin_F() end,
      }

      vim.api.nvim_set_keymap("n", "F", "", keymap_callback_builtin_F)
      vim.api.nvim_set_keymap("x", "F", "", keymap_callback_builtin_F)
      vim.api.nvim_set_keymap("o", "F", "", keymap_callback_builtin_F)

      local keymap_callback_builtin_t = {
        callback = function() require("nvim-treesitter.textobjects.repeatable_move").builtin_t() end,
      }

      vim.api.nvim_set_keymap("n", "t", "", keymap_callback_builtin_t)
      vim.api.nvim_set_keymap("x", "t", "", keymap_callback_builtin_t)
      vim.api.nvim_set_keymap("o", "t", "", keymap_callback_builtin_t)

      local keymap_callback_builtin_T = {
        callback = function() require("nvim-treesitter.textobjects.repeatable_move").builtin_T() end,
      }

      vim.api.nvim_set_keymap("n", "T", "", keymap_callback_builtin_T)
      vim.api.nvim_set_keymap("x", "T", "", keymap_callback_builtin_T)
      vim.api.nvim_set_keymap("o", "T", "", keymap_callback_builtin_T)
    end,
  },
  {
    "HiPhish/nvim-ts-rainbow2",
    event = require("wuelnerdotexe.plugin.config").open_file_event,
    dependencies = "nvim-treesitter/nvim-treesitter",
  },
  {
    "windwp/nvim-ts-autotag",
    event = [[InsertEnter *.html,*.js,*.jsx,*.tsx,*.md,*.markdown]],
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      require("nvim-ts-autotag").setup({
        filetypes = { "html", "javascript", "javascriptreact", "typescriptreact", "markdown" },
      })

      vim.api.nvim_command("doautoall <nomodeline> FileType")
    end,
  },
  {
    "danymat/neogen",
    cmd = "Neogen",
    dependencies = { "nvim-treesitter/nvim-treesitter", "L3MON4D3/LuaSnip" },
    config = function() require("neogen").setup({ snippet_engine = "luasnip" }) end,
  },
}
