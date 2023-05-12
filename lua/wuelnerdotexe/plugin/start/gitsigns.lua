return {
  "lewis6991/gitsigns.nvim",
  lazy = true,
  init = function()
    vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile", "BufWritePost" }, {
      callback = function()
        if package.loaded["gitsigns"] then return true end

        vim.api.nvim_call_function("system", {
          "git -C" .. " " .. vim.api.nvim_call_function("expand", { "%:p:h" }) .. " " .. "rev-parse",
        })

        if vim.api.nvim_get_vvar("shell_error") == 0 then
          require("lazy").load({ plugins = { "gitsigns.nvim" } })

          return true
        end
      end,
    })

    require("wuelnerdotexe.plugin.util").set_option("signcolumn", "yes:1")
  end,
  config = function()
    require("gitsigns").setup({
      signs = {
        add = { hl = "GitSignsAdd", text = "│" },
        change = { hl = "GitSignsChange", text = "│" },
        delete = { hl = "GitSignsDelete", text = "_" },
        topdelete = { hl = "GitSignsDelete", text = "‾" },
        changedelete = { hl = "GitSignsChange", text = "│" },
      },
      current_line_blame_opts = { delay = 42 },
      sign_priority = 1,
      update_debounce = 284,
      preview_config = { border = require("wuelnerdotexe.plugin.config").border and "rounded" or "none", row = 1 },
      on_attach = function(bufnr)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>hr", "", {
          callback = function() require("gitsigns").reset_hunk() end,
        })

        vim.api.nvim_buf_set_keymap(bufnr, "v", "<leader>hr", "", {
          callback = function()
            require("gitsigns").reset_hunk({
              vim.api.nvim_call_function("line", { "." }),
              vim.api.nvim_call_function("line", { "v" }),
            })
          end,
        })

        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>hs", "", {
          callback = function() require("gitsigns").stage_hunk() end,
        })

        vim.api.nvim_buf_set_keymap(bufnr, "v", "<leader>hs", "", {
          callback = function()
            require("gitsigns").stage_hunk({
              vim.api.nvim_call_function("line", { "." }),
              vim.api.nvim_call_function("line", { "v" }),
            })
          end,
        })

        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>hp", "", {
          callback = function() require("gitsigns").preview_hunk() end,
        })

        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>bp", "", {
          callback = function() require("gitsigns").blame_line({ full = true }) end,
        })

        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>bt", "", {
          callback = function() require("gitsigns").toggle_current_line_blame() end,
        })

        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>dt", "", {
          callback = function() require("gitsigns").toggle_deleted() end,
        })

        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>gd", "", {
          callback = function() require("gitsigns").diffthis("~") end,
        })

        vim.api.nvim_buf_set_keymap(bufnr, "n", "]h", "", { callback = function() require("gitsigns").next_hunk() end })
        vim.api.nvim_buf_set_keymap(bufnr, "n", "[h", "", { callback = function() require("gitsigns").prev_hunk() end })
      end,
    })

    if vim.api.nvim_get_vvar("vim_did_enter") == 0 then
      vim.api.nvim_create_autocmd("UIEnter", {
        once = true,
        callback = function()
          if package.loaded["scrollbar"] then require("scrollbar.handlers.gitsigns").setup() end
        end,
      })
    elseif package.loaded["scrollbar"] then
      require("scrollbar.handlers.gitsigns").setup()
    end
  end,
}
