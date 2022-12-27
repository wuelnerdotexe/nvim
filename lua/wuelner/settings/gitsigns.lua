local config = function()
  local buf_set_keymap = vim.api.nvim_buf_set_keymap

  local reset_hunk = function()
    package.loaded.gitsigns.reset_hunk()
  end

  local stage_hunk = function()
    package.loaded.gitsigns.stage_hunk()
  end

  local reset_hunk_callback = {
    callback = function()
      reset_hunk()
    end,
  }

  local stage_hunk_callback = {
    callback = function()
      stage_hunk()
    end,
  }

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
      buf_set_keymap(bufnr, "n", "<leader>hr", "", reset_hunk_callback)
      buf_set_keymap(bufnr, "v", "<leader>hr", "", reset_hunk_callback)
      buf_set_keymap(bufnr, "n", "<leader>hs", "", stage_hunk_callback)
      buf_set_keymap(bufnr, "v", "<leader>hs", "", stage_hunk_callback)

      buf_set_keymap(bufnr, "n", "<leader>hp", "", {
        callback = function()
          package.loaded.gitsigns.preview_hunk()
        end,
      })

      buf_set_keymap(bufnr, "n", "<leader>hu", "", {
        callback = function()
          package.loaded.gitsigns.undo_stage_hunk()
        end,
      })

      local diff = vim.api.nvim_get_option_value("diff", { win = 0 })

      buf_set_keymap(bufnr, "n", "[h", "", {
        callback = function()
          if diff then
            return "[h"
          end

          schedule(function()
            package.loaded.gitsigns.prev_hunk()
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
            package.loaded.gitsigns.next_hunk()
          end)

          return "<Ignore>"
        end,
        expr = true,
        replace_keycodes = true,
      })
    end,
  })
end

return config
