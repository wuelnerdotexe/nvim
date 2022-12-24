local config = function()
  local keymap_set = vim.keymap.set
  local keymap_mode = { "n", "v" }
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
      local wo_diff = vim.wo.diff
      local keymap_opts = { buffer = bufnr }
      local keymap_opts_with_expr = { buffer = bufnr, expr = true }

      keymap_set("n", "[h", function()
        if wo_diff then
          return "[h"
        end

        schedule(function()
          package.loaded.gitsigns.prev_hunk()
        end)

        return "<Ignore>"
      end, keymap_opts_with_expr)
      keymap_set("n", "]h", function()
        if wo_diff then
          return "]h"
        end

        schedule(function()
          package.loaded.gitsigns.next_hunk()
        end)

        return "<Ignore>"
      end, keymap_opts_with_expr)
      keymap_set("n", "<leader>hp", package.loaded.gitsigns.preview_hunk, keymap_opts)
      keymap_set(keymap_mode, "<leader>hr", package.loaded.gitsigns.reset_hunk, keymap_opts)
      keymap_set(keymap_mode, "<leader>hs", package.loaded.gitsigns.stage_hunk, keymap_opts)
      keymap_set("n", "<leader>hu", package.loaded.gitsigns.undo_stage_hunk, keymap_opts)
    end,
  })
end

return config
