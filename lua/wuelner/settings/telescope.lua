local config = function()
  local select_horizontal = function()
    require("telescope.actions").select_horizontal()
  end

  require("telescope").setup({
    pickers = {
      fd = {
        find_command = {
          "fd",
          "-I",
          "-H",
          "-E",
          "{.git,.svn,.hg,CSV,.DS_Store,Thumbs.db,node_modules,bower_components,*.code-search}",
          "-t",
          "f",
        },
      },
    },
    defaults = {
      prompt_prefix = "  ",
      selection_caret = "  ",
      multi_icon = " ",
      winblend = 10,
      vimgrep_arguments = {
        "rg",
        "--hidden",
        "--glob=!.git,!.svn,!.hg,!CSV,!.DS_Store,!Thumbs.db,!node_modules,!bower_components,!*.code-search",
        "--ignore-case",
        "--with-filename",
        "--line-number",
        "--column",
        "--no-heading",
        "--trim",
        "--color=never",
      },
      buffer_previewer_maker = function(filepath, bufnr, opts)
        opts = opts or {}

        vim.loop.fs_stat(filepath, function(_, stat)
          if not stat or stat.size > 100000 then
            return
          end

          require("telescope.previewers").buffer_previewer_maker(filepath, bufnr, opts)
        end)
      end,
      mappings = {
        n = { ["<C-x>"] = false, ["<C-s>"] = select_horizontal },
        i = { ["<C-x>"] = false, ["<C-s>"] = select_horizontal },
      },
    },
    extensions = { fzf = { fuzzy = false, case_mode = "ignore_case" } },
  })

  require("telescope").load_extension("fzf")

  vim.api.nvim_create_autocmd("User", {
    pattern = "TelescopePreviewerLoaded",
    callback = function()
      vim.api.nvim_set_option_value("wrap", false, { scope = "local" })
    end,
  })

  local set_keymap = vim.api.nvim_set_keymap

  set_keymap("n", "<leader>ff", "", {
    callback = function()
      require("telescope.builtin").fd()
    end,
  })

  set_keymap("n", "<leader>of", "", {
    callback = function()
      require("telescope.builtin").oldfiles()
    end,
  })

  set_keymap("n", "<leader>mf", "", {
    callback = function()
      require("telescope.builtin").marks()
    end,
  })

  set_keymap("n", "<leader>wf", "", {
    callback = function()
      require("telescope.builtin").live_grep()
    end,
  })
end

return config
