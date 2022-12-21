local M = {}

M.config = function()
  local select_horizontal = require("telescope.actions").select_horizontal
  local mappings = { ["<C-x>"] = false, ["<C-s>"] = select_horizontal }

  require("telescope").setup({
    pickers = { fd = { find_command = { "fd", "-I", "-H", "-t", "f" } } },
    defaults = {
      prompt_prefix = "  ",
      selection_caret = "  ",
      multi_icon = " ",
      winblend = vim.opt.winblend:get(),
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
      buffer_previewer_maker = function(filepath, bufnr, opts)
        opts = opts or {}

        vim.loop.fs_stat(filepath, function(_, stat)
          if not stat or stat.size > 100000 then
            return
          else
            require("telescope.previewers").buffer_previewer_maker(
              filepath,
              bufnr,
              opts
            )
          end
        end)
      end,
      mappings = { n = mappings, i = mappings },
    },
    extensions = { fzf = { fuzzy = false, case_mode = "ignore_case" } },
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
