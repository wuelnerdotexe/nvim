return {
  "lewis6991/gitsigns.nvim",
  event = { "BufNewFile", "BufRead", "BufAdd" },
  config = function()
    local buf_set_keymap = vim.api.nvim_buf_set_keymap
    local reset_hunk = require("gitsigns").reset_hunk
    local stage_hunk = require("gitsigns").stage_hunk
    local schedule = vim.schedule

    require("gitsigns").setup({
      signs = {
        add = { hl = "GitSignsAdd", text = "│" },
        change = { hl = "GitSignsChange", text = "│" },
        delete = { hl = "GitSignsDelete", text = "_" },
        topdelete = { hl = "GitSignsDelete", text = "‾" },
        changedelete = { hl = "GitSignsChange", text = "│" },
      },
      current_line_blame_opts = { delay = 40 },
      sign_priority = 7,
      update_debounce = 300,
      preview_config = { border = "rounded" },
      on_attach = function(bufnr)
        buf_set_keymap(bufnr, "n", "<leader>hr", "", {
          callback = function()
            reset_hunk()
          end,
        })

        buf_set_keymap(bufnr, "v", "<leader>hr", "", {
          callback = function()
            reset_hunk()
          end,
        })

        buf_set_keymap(bufnr, "n", "<leader>hs", "", {
          callback = function()
            stage_hunk()
          end,
        })

        buf_set_keymap(bufnr, "v", "<leader>hs", "", {
          callback = function()
            stage_hunk()
          end,
        })

        buf_set_keymap(bufnr, "n", "<leader>hp", "", {
          callback = function()
            require("gitsigns").preview_hunk()
          end,
        })

        buf_set_keymap(bufnr, "n", "<leader>bp", "", {
          callback = function()
            require("gitsigns").blame_line({ full = true })
          end,
        })

        buf_set_keymap(bufnr, "n", "<leader>bt", "", {
          callback = function()
            require("gitsigns").toggle_current_line_blame()
          end,
        })

        buf_set_keymap(bufnr, "n", "<leader>dt", "", {
          callback = function()
            require("gitsigns").toggle_deleted()
          end,
        })

        buf_set_keymap(bufnr, "n", "<leader>gd", "", {
          callback = function()
            require("gitsigns").diffthis("~")
          end,
        })

        local diff = vim.api.nvim_get_option_value("diff", { win = 0 })

        buf_set_keymap(bufnr, "n", "[h", "", {
          callback = function()
            if diff then
              return "[h"
            end

            schedule(function()
              require("gitsigns").prev_hunk()
            end)

            return "<Ignore>"
          end,
          expr = true,
          replace_keycodes = true,
        })

        buf_set_keymap(bufnr, "n", "]h", "", {
          callback = function()
            if diff then
              return "]h"
            end

            schedule(function()
              require("gitsigns").next_hunk()
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
