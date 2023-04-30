return {
  "lewis6991/gitsigns.nvim",
  lazy = true,
  init = function()
    vim.api.nvim_create_autocmd(require("wuelnerdotexe.plugin.config").open_file_event, {
      callback = function()
        vim.api.nvim_call_function("system", {
          "git -C" .. " " .. vim.api.nvim_call_function("expand", { "%:p:h" }) .. " " .. "rev-parse",
        })

        if vim.api.nvim_get_vvar("shell_error") == 0 then
          vim.schedule(function() require("lazy").load({ plugins = { "gitsigns.nvim" } }) end)

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
      sign_priority = require("wuelnerdotexe.plugin.config").signs_priority.git,
      update_debounce = 284,
      preview_config = { border = require("wuelnerdotexe.plugin.util").get_border().style, row = 1 },
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

        vim.api.nvim_buf_set_keymap(bufnr, "n", "]h", "", {
          callback = function()
            if vim.api.nvim_get_option_value("diff", { win = 0 }) then return "]h" end

            vim.schedule(function() require("gitsigns").next_hunk() end)

            return "<Ignore>"
          end,
          expr = true,
          replace_keycodes = true,
        })

        vim.api.nvim_buf_set_keymap(bufnr, "n", "[h", "", {
          callback = function()
            if vim.api.nvim_get_option_value("diff", { win = 0 }) then return "[h" end

            vim.schedule(function() require("gitsigns").prev_hunk() end)

            return "<Ignore>"
          end,
          expr = true,
          replace_keycodes = true,
        })
      end,
    })

    if package.loaded["scrollbar"] then require("scrollbar.handlers.gitsigns").setup() end
  end,
}
