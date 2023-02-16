return {
  "lewis6991/gitsigns.nvim",
  event = { "BufNewFile", "BufRead", "BufAdd" },
  dependencies = { "nvim-treesitter/nvim-treesitter-textobjects", dependencies = "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("gitsigns").setup({
      signs = {
        add = { hl = "GitSignsAdd", text = "│" },
        change = { hl = "GitSignsChange", text = "│" },
        delete = { hl = "GitSignsDelete", text = "_" },
        topdelete = { hl = "GitSignsDelete", text = "‾" },
        changedelete = { hl = "GitSignsChange", text = "│" },
      },
      current_line_blame_opts = { delay = 42 },
      sign_priority = 7,
      update_debounce = 284,
      preview_config = { border = "rounded" },
      on_attach = function(bufnr)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>hr", "", {
          callback = function()
            require("gitsigns").reset_hunk()
          end,
        })

        vim.api.nvim_buf_set_keymap(bufnr, "v", "<leader>hr", "", {
          callback = function()
            require("gitsigns").reset_hunk()
          end,
        })

        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>hs", "", {
          callback = function()
            require("gitsigns").stage_hunk()
          end,
        })

        vim.api.nvim_buf_set_keymap(bufnr, "v", "<leader>hs", "", {
          callback = function()
            require("gitsigns").stage_hunk()
          end,
        })

        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>hp", "", {
          callback = function()
            require("gitsigns").preview_hunk()
          end,
        })

        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>bp", "", {
          callback = function()
            require("gitsigns").blame_line({ full = true })
          end,
        })

        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>bt", "", {
          callback = function()
            require("gitsigns").toggle_current_line_blame()
          end,
        })

        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>dt", "", {
          callback = function()
            require("gitsigns").toggle_deleted()
          end,
        })

        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>gd", "", {
          callback = function()
            require("gitsigns").diffthis("~")
          end,
        })

        local next_hunk_repeatable, prev_hunk_repeatable =
          require("nvim-treesitter.textobjects.repeatable_move").make_repeatable_move_pair(
            require("gitsigns").next_hunk,
            require("gitsigns").prev_hunk
          )

        vim.api.nvim_buf_set_keymap(bufnr, "n", "]h", "", {
          callback = function()
            if vim.api.nvim_get_option_value("diff", { win = 0 }) then
              return "]h"
            end

            vim.schedule(function()
              next_hunk_repeatable()
            end)

            return "<Ignore>"
          end,
          expr = true,
          replace_keycodes = true,
        })

        vim.api.nvim_buf_set_keymap(bufnr, "n", "[h", "", {
          callback = function()
            if vim.api.nvim_get_option_value("diff", { win = 0 }) then
              return "[h"
            end

            vim.schedule(function()
              prev_hunk_repeatable()
            end)

            return "<Ignore>"
          end,
          expr = true,
          replace_keycodes = true,
        })
      end,
    })
  end,
}
