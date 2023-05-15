return {
  "nvim-telescope/telescope.nvim",
  lazy = true,
  cmd = "Telescope",
  keys = {
    { "z=", function() require("telescope.builtin").spell_suggest() end },
    {
      "<leader>ff",
      function() require("telescope.builtin").find_files() end,
      desc = "General: [f]ind [f]iles in the current directory",
    },
    {
      "<leader>of",
      function() require("telescope.builtin").oldfiles() end,
      desc = "General: [f]ind recently [o]pened files",
    },
    {
      "<leader>mf",
      function() require("telescope.builtin").marks() end,
      desc = "General: [f]ind Vim files [m]arks",
    },
    {
      "<leader>bf",
      function() require("telescope.builtin").buffers() end,
      desc = "General: [f]ind opened [b]uffers",
    },
    {
      "<leader>wf",
      function() require("telescope.builtin").live_grep() end,
      desc = "General: [f]ind [w]ord in the current directory",
    },
    {
      "<leader>wf",
      function() require("telescope.builtin").grep_string() end,
      desc = "General: [f]ind [w]ord in the current directory",
      mode = "x",
    },
    {
      "<leader>gf",
      function() require("telescope.builtin").git_status() end,
      desc = "General: [f]ind files from [g]it status",
    },
    { "<leader>rf", function() require("telescope.builtin").resume() end, desc = "General: [f]ind [r]esume" },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "nvim-treesitter/nvim-treesitter",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  init = function()
    require("wuelnerdotexe.plugin.util").set_option("termguicolors", true)
    require("wuelnerdotexe.plugin.util").set_option("winblend", require("wuelnerdotexe.plugin.config").blend)
    require("wuelnerdotexe.plugin.util").set_option("pumblend", require("wuelnerdotexe.plugin.config").blend)
  end,
  config = function()
    local exclude_globs = "{"

    for i, glob in pairs(require("wuelnerdotexe.plugin.config").exclude_search_files) do
      exclude_globs = i == 1 and exclude_globs .. glob or exclude_globs .. "," .. glob
    end

    exclude_globs = exclude_globs .. "}"

    require("telescope").setup({
      pickers = {
        builtin = { include_extensions = true, use_default_opts = true },
        planets = { show_pluto = true, show_moon = true },
        buffers = { ignore_current_buffer = true, sort_mru = true },
        colorscheme = { enable_preview = true },
        keymaps = { show_plug = false },
        find_files = { find_command = { "fd", "-I", "-H", "-E", exclude_globs, "-t", "f", "--color", "never" } },
        git_files = { show_untracked = true },
        git_status = {
          git_icons = {
            added = "A",
            deleted = "D",
            changed = "M",
            renamed = "R",
            copied = "C",
            untracked = "?",
            unmerged = "U",
          },
        },
      },
      defaults = {
        sorting_strategy = "ascending",
        layout_config = { prompt_position = "top" },
        winblend = require("wuelnerdotexe.plugin.config").blend,
        prompt_prefix = "  ",
        selection_caret = "  ",
        multi_icon = "  ",
        borderchars = require("wuelnerdotexe.plugin.config").border
            and { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }
          or { " ", " ", " ", " ", " ", " ", " ", " " },
        default_mappings = {
          i = {
            ["<M-q>"] = require("telescope.actions").send_selected_to_qflist + require("telescope.actions").open_qflist,
            ["<C-q>"] = require("telescope.actions").send_to_qflist + require("telescope.actions").open_qflist,
            ["<Esc>"] = require("telescope.actions").close,
            ["<C-e>"] = require("telescope.actions").close,
            ["<C-y>"] = require("telescope.actions").select_default,
            ["<CR>"] = require("telescope.actions").select_default,
            ["<Tab>"] = require("telescope.actions").toggle_selection
              + require("telescope.actions").move_selection_worse,
            ["<S-Tab>"] = require("telescope.actions").toggle_selection
              + require("telescope.actions").move_selection_better,
            ["<Down>"] = require("telescope.actions").move_selection_next,
            ["<Up>"] = require("telescope.actions").move_selection_previous,
            ["<C-n>"] = require("telescope.actions").move_selection_next,
            ["<C-p>"] = require("telescope.actions").move_selection_previous,
            ["<C-b>"] = require("telescope.actions").preview_scrolling_up,
            ["<C-f>"] = require("telescope.actions").preview_scrolling_down,
            ["<C-s>"] = require("telescope.actions").select_horizontal,
            ["<C-v>"] = require("telescope.actions").select_vertical,
            ["<C-t>"] = require("telescope.actions").select_tab,
            ["<C-j>"] = require("telescope.actions").nop,
          },
        },
        preview = { timeout = 284 },
        vimgrep_arguments = {
          "rg",
          "--hidden",
          "--glob=!" .. exclude_globs,
          "--ignore-case",
          "--with-filename",
          "--line-number",
          "--column",
          "--no-heading",
          "--trim",
          "--color=never",
        },
      },
      extensions = { fzf = { case_mode = "ignore_case" } },
    })

    require("telescope").load_extension("fzf")

    vim.api.nvim_create_autocmd("User", {
      pattern = "TelescopePreviewerLoaded",
      callback = function(ev)
        vim.api.nvim_set_option_value("number", true, { buf = ev.buf })
        vim.api.nvim_set_option_value("wrap", true, { buf = ev.buf })
      end,
    })

    vim.api.nvim_create_autocmd("WinLeave", {
      callback = function(ev)
        if vim.api.nvim_get_option_value("filetype", { buf = ev.buf }) == "TelescopePrompt" then
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "i", false)
        end
      end,
    })
  end,
}
