local M = {}

M.config = function()
  require("gitsigns").setup({
    signs = {
      add = { hl = "GitSignsAdd", text = "┃" },
      change = { hl = "GitSignsChange", text = "┃" },
      delete = { hl = "GitSignsDelete", text = "▁" },
      topdelete = { hl = "GitSignsDelete", text = "▔" },
      changedelete = { hl = "GitSignsChange", text = "┃" },
    },
    current_line_blame_opts = { delay = 40 },
    sign_priority = 7,
    update_debounce = 300,
    preview_config = { border = "rounded" },
    on_attach = function(bufnr)
      local keymap_set = vim.keymap.set
      local wo_diff = vim.wo.diff
      local vim_schedule = vim.schedule

      keymap_set("n", "[h", function()
        if wo_diff then
          return "[h"
        end

        vim_schedule(function()
          package.loaded.gitsigns.prev_hunk()
        end)

        return "<Ignore>"
      end, { expr = true, buffer = bufnr })
      keymap_set("n", "]h", function()
        if wo_diff then
          return "]h"
        end

        vim_schedule(function()
          package.loaded.gitsigns.next_hunk()
        end)

        return "<Ignore>"
      end, { expr = true, buffer = bufnr })
      keymap_set(
        "n",
        "<leader>hp",
        package.loaded.gitsigns.preview_hunk,
        { buffer = bufnr }
      )
      keymap_set(
        { "n", "v" },
        "<leader>hr",
        "<Cmd>Gitsigns reset_hunk<CR>",
        { buffer = bufnr }
      )
      keymap_set(
        { "n", "v" },
        "<leader>hs",
        "<Cmd>Gitsigns stage_hunk<CR>",
        { buffer = bufnr }
      )
      keymap_set(
        "n",
        "<leader>hu",
        package.loaded.gitsigns.undo_stage_hunk,
        { buffer = bufnr }
      )
    end,
  })
end

return M
