local M = {}

M.config = function()
  local telescope = require("telescope")
  local command_center = require("command_center")
  local telescope_actions = require("telescope.actions")

  telescope.setup({
    defaults = {
      mappings = {
        n = {
          ["<C-x>"] = false,
          ["<C-s>"] = telescope_actions.select_horizontal,
        },
        i = {
          ["<Esc>"] = telescope_actions.close,
          ["<C-x>"] = false,
          ["<C-s>"] = telescope_actions.select_horizontal,
        },
      },
      file_ignore_patterns = {
        ".git",
        ".svn",
        ".hg",
        "CSV",
        ".DS_Store",
        "Thumbs.db",
        "node_modules",
        "bower_components",
        "*.code-search",
      },
    },
    extensions = {
      command_center = {
        components = {
          command_center.component.DESC,
          command_center.component.KEYS,
        },
        sort_by = {
          command_center.component.CATEGORY,
          command_center.component.DESC,
          command_center.component.KEYS,
        },
        auto_replace_desc_with_cmd = false,
      },
    },
  })

  telescope.load_extension("fzf")
  telescope.load_extension("command_center")

  local vim = vim

  vim.api.nvim_create_autocmd("User", {
    pattern = "TelescopePreviewerLoaded",
    command = "setlocal wrap",
  })

  local keymap_set = vim.keymap.set
  local telescope_builtin = require("telescope.builtin")

  keymap_set("n", "<leader>ff", telescope_builtin.find_files)
  keymap_set("n", "<leader>of", telescope_builtin.oldfiles)
  keymap_set("n", "<leader>mf", telescope_builtin.marks)
  keymap_set("n", "<leader>wf", telescope_builtin.live_grep)
  keymap_set("n", "<leader>hf", telescope_builtin.help_tags)
end

return M
