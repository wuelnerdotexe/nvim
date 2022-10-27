local M = {}

M.config = function()
  local select_horizontal = require("telescope.actions").select_horizontal
  local component_DESC = require("command_center").component.DESC
  local component_KEYS = require("command_center").component.KEYS

  require("telescope").setup({
    defaults = {
      mappings = {
        n = {
          ["<C-x>"] = false,
          ["<C-s>"] = select_horizontal,
        },
        i = {
          ["<C-x>"] = false,
          ["<C-s>"] = select_horizontal,
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
          component_DESC,
          component_KEYS,
        },
        sort_by = {
          component_DESC,
          component_KEYS,
        },
        auto_replace_desc_with_cmd = false,
      },
    },
  })

  local load_extension = require("telescope").load_extension

  load_extension("fzf")
  load_extension("command_center")

  vim.api.nvim_create_autocmd("User", {
    pattern = "TelescopePreviewerLoaded",
    command = "setlocal wrap",
  })

  local keymap_set = vim.keymap.set

  keymap_set("n", "<leader>ff", require("telescope.builtin").find_files)
  keymap_set("n", "<leader>of", require("telescope.builtin").oldfiles)
  keymap_set("n", "<leader>mf", require("telescope.builtin").marks)
  keymap_set("n", "<leader>wf", require("telescope.builtin").live_grep)
  keymap_set("n", "<leader>hf", require("telescope.builtin").help_tags)
end

return M
