return {
  "stevearc/aerial.nvim",
  enabled = not require("wuelnerdotexe.plugin.config").minimal_setup,
  event = require("wuelnerdotexe.plugin.config").open_file_event,
  config = function()
    vim.api.nvim_set_option_value("foldmethod", "manual", TBL)

    local sidebar_width = require("wuelnerdotexe.plugin.util").get_sidebar_width()

    require("aerial").setup({
      layout = {
        max_width = { sidebar_width, 0.25 },
        width = sidebar_width,
        min_width = { sidebar_width, 0.25 },
        win_opts = { cursorline = true },
        default_direction = "right",
        placement = "edge",
      },
      attach_mode = "global",
      keymaps = {
        ["p"] = false,
        ["<C-j>"] = false,
        ["<C-k>"] = false,
        ["o"] = false,
        ["O"] = false,
        ["l"] = false,
        ["L"] = false,
        ["h"] = false,
        ["H"] = false,
      },
      disable_max_lines = 1000,
      disable_max_size = 102400,
      filter_kind = false,
      highlight_mode = "last",
      highlight_closest = false,
      highlight_on_jump = 125,
      icons = require("wuelnerdotexe.plugin.config").kind_icons,
      manage_folds = "auto",
      link_folds_to_tree = true,
      link_tree_to_folds = true,
      on_attach = function(bufnr)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "}", "", {
          callback = function() vim.api.nvim_command("AerialNext") end,
        })

        vim.api.nvim_buf_set_keymap(bufnr, "n", "{", "", {
          callback = function() vim.api.nvim_command("AerialPrev") end,
        })
      end,
      show_guides = true,
      guides = { mid_item = "│ ", last_item = "└ ", nested_top = "│ " },
      float = { border = require("wuelnerdotexe.plugin.util").get_border().style, relative = "editor" },
      lsp = { diagnostics_trigger_update = false, update_delay = 284 },
      treesitter = { update_delay = 284 },
      markdown = { update_delay = 284 },
      man = { update_delay = 284 },
    })

    vim.api.nvim_set_keymap("n", "<leader>st", "", { callback = function() require("aerial").toggle() end })
  end,
}
