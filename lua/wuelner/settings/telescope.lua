local M = {}

M.config = function()
  local select_horizontal = require("telescope.actions").select_horizontal
  local mappings = { ["<C-x>"] = false, ["<C-s>"] = select_horizontal }

  require("telescope").setup({
    pickers = { fd = { find_command = { "fd", "-I", "-H", "-t", "f" } } },
    defaults = {
      mappings = { n = mappings, i = mappings },
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

  keymap_set("n", "<leader>ff", require("telescope.builtin").fd)
  keymap_set("n", "<leader>of", require("telescope.builtin").oldfiles)
  keymap_set("n", "<leader>mf", require("telescope.builtin").marks)
  keymap_set("n", "<leader>wf", require("telescope.builtin").live_grep)
  keymap_set("n", "<leader>hf", require("telescope.builtin").help_tags)
end

return M
