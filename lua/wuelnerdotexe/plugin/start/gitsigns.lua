return {
  "lewis6991/gitsigns.nvim",
  cmd = "Gitsigns",
  lazy = true,
  init = function()
    require("wuelnerdotexe.plugin.util").add_colorscheme_integration("gitsigns")

    require("wuelnerdotexe.plugin.util").set_option("termguicolors", true)
    require("wuelnerdotexe.plugin.util").set_option("signcolumn", "yes:1")

    vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile", "BufWritePost" }, {
      group = vim.api.nvim_create_augroup("load_gitsigns", { clear = false }),
      callback = function()
        if package.loaded["gitsigns"] then
          vim.api.nvim_clear_autocmds({ group = "load_gitsigns" })

          return true
        end

        vim.api.nvim_call_function("system", {
          "git -C " .. vim.api.nvim_call_function("expand", { "%:p:h" }) .. " rev-parse",
        })

        if vim.api.nvim_get_vvar("shell_error") ~= 0 then return end

        vim.api.nvim_clear_autocmds({ group = "load_gitsigns" })

        require("lazy").load({ plugins = { "gitsigns.nvim" } })
      end,
    })
  end,
  config = function()
    local updatetime = vim.api.nvim_get_option_value("updatetime", { scope = "global" })

    require("gitsigns").setup({
      signs = { add = { text = "│" }, change = { text = "│" } },
      current_line_blame = true,
      current_line_blame_opts = { delay = updatetime },
      sign_priority = 1,
      update_debounce = updatetime,
      preview_config = { border = "rounded", row = 1, col = 0 },
      on_attach = function(bufnr)
        vim.api.nvim_buf_set_keymap(bufnr, "x", "<localleader>hr", "", {
          callback = function()
            require("gitsigns").reset_hunk({
              vim.api.nvim_call_function("line", { "." }),
              vim.api.nvim_call_function("line", { "v" }),
            })
          end,
          desc = "Git: [r]eset the current [h]unk",
        })

        vim.api.nvim_buf_set_keymap(bufnr, "n", "<localleader>hs", "", {
          callback = function() require("gitsigns").stage_hunk() end,
          desc = "Git: [s]tage the current [h]unk",
        })

        vim.api.nvim_buf_set_keymap(bufnr, "x", "<localleader>hs", "", {
          callback = function()
            require("gitsigns").stage_hunk({
              vim.api.nvim_call_function("line", { "." }),
              vim.api.nvim_call_function("line", { "v" }),
            })
          end,
          desc = "Git: [s]tage the current [h]unk",
        })

        vim.api.nvim_buf_set_keymap(bufnr, "n", "<localleader>hp", "", {
          callback = function() require("gitsigns").preview_hunk() end,
          desc = "Git: [p]review the current [h]unk",
        })

        vim.api.nvim_buf_set_keymap(bufnr, "n", "<localleader>bp", "", {
          callback = function() require("gitsigns").blame_line({ full = true }) end,
          desc = "Git: [p]review the current line [b]lame",
        })

        vim.api.nvim_buf_set_keymap(bufnr, "n", "<localleader>gd", "", {
          callback = function() require("gitsigns").diffthis("~") end,
          desc = "Git: split [g]it [d]iffs",
        })

        vim.api.nvim_buf_set_keymap(bufnr, "n", "]h", "", { callback = function() require("gitsigns").next_hunk() end })
        vim.api.nvim_buf_set_keymap(bufnr, "n", "[h", "", { callback = function() require("gitsigns").prev_hunk() end })
      end,
    })

    if vim.api.nvim_get_vvar("vim_did_enter") == 0 then
      vim.api.nvim_create_autocmd("UIEnter", {
        callback = function()
          if package.loaded["scrollbar"] then require("scrollbar.handlers.gitsigns").setup() end
        end,
        once = true,
      })
    elseif package.loaded["scrollbar"] then
      require("scrollbar.handlers.gitsigns").setup()
    end
  end,
}
