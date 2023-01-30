return {
  "lewis6991/gitsigns.nvim",
  event = { "BufNewFile", "BufRead", "BufAdd" },
  config = function()
    local buf_set_keymap = vim.api.nvim_buf_set_keymap
    local reset_hunk = require("gitsigns").reset_hunk
    local stage_hunk = require("gitsigns").stage_hunk
    local preview_hunk = require("gitsigns").preview_hunk
    local blame_line = require("gitsigns").blame_line
    local toggle_current_line_blame = require("gitsigns").toggle_current_line_blame
    local toggle_deleted = require("gitsigns").toggle_deleted
    local diffthis = require("gitsigns").diffthis
    local get_option_value = vim.api.nvim_get_option_value
    local schedule = vim.schedule
    local prev_hunk = require("gitsigns").prev_hunk
    local next_hunk = require("gitsigns").next_hunk

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
            preview_hunk()
          end,
        })

        buf_set_keymap(bufnr, "n", "<leader>bp", "", {
          callback = function()
            blame_line({ full = true })
          end,
        })

        buf_set_keymap(bufnr, "n", "<leader>bt", "", {
          callback = function()
            toggle_current_line_blame()
          end,
        })

        buf_set_keymap(bufnr, "n", "<leader>dt", "", {
          callback = function()
            toggle_deleted()
          end,
        })

        buf_set_keymap(bufnr, "n", "<leader>gd", "", {
          callback = function()
            diffthis("~")
          end,
        })

        local diff = get_option_value("diff", { win = 0 })

        buf_set_keymap(bufnr, "n", "[h", "", {
          callback = function()
            if diff then
              return "[h"
            end

            schedule(function()
              prev_hunk()
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
              next_hunk()
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
