local M = {}

M.config = function()
  local find_command = { "fd", "-I", "-H", "-t", "f" }
  local select_horizontal = require("telescope.actions").select_horizontal

  require("telescope").setup({
    pickers = {
      find_files = { find_command = find_command },
      fd = { find_command = find_command },
    },
    defaults = {
      mappings = {
        n = { ["<C-x>"] = false, ["<C-s>"] = select_horizontal },
        i = { ["<C-x>"] = false, ["<C-s>"] = select_horizontal },
      },
      vimgrep_arguments = {
        "rg",
        "--hidden",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--ignore-case",
        "--trim",
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
  })

  require("telescope").load_extension("fzf")

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
