return {
  "stevearc/aerial.nvim",
  enabled = not require("wuelnerdotexe.plugin.config").minimal_setup,
  event = require("wuelnerdotexe.plugin.config").open_file_event,
  init = function()
    require("wuelnerdotexe.plugin.util").set_option("foldenable", true)
    require("wuelnerdotexe.plugin.util").set_option("foldmethod", "manual")
    require("wuelnerdotexe.plugin.util").set_option("foldlevelstart", 99)
    require("wuelnerdotexe.plugin.util").set_option("winblend", require("wuelnerdotexe.plugin.config").blend)
    require("wuelnerdotexe.plugin.util").set_option("pumblend", require("wuelnerdotexe.plugin.config").blend)
  end,
  dependencies = "nvim-treesitter/nvim-treesitter",
  config = function()
    local sidebar_width = require("wuelnerdotexe.plugin.util").get_sidebar_width()

    require("aerial").setup({
      backends = { "lsp", "treesitter", "markdown", "man" },
      layout = {
        max_width = { sidebar_width, 0.25 },
        width = sidebar_width,
        min_width = { sidebar_width, 0.25 },
        win_opts = { cursorline = true },
        placement = "edge",
      },
      attach_mode = "global",
      keymaps = {
        ["p"] = false,
        ["<C-j>"] = false,
        ["<C-k>"] = false,
        ["o"] = false,
        ["O"] = false,
        ["L"] = false,
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
      float = { border = require("wuelnerdotexe.plugin.config").border and "rounded" or "none", relative = "editor" },
      nav = {
        border = require("wuelnerdotexe.plugin.config").border and "rounded" or "none",
        win_opts = { cursorline = true, winblend = require("wuelnerdotexe.plugin.config").blend },
        keymaps = { ["<C-c>"] = false, ["<Esc>"] = "actions.close" },
      },
      lsp = { diagnostics_trigger_update = false, update_delay = 284 },
      treesitter = { update_delay = 284 },
      markdown = { update_delay = 284 },
      man = { update_delay = 284 },
    })

    vim.api.nvim_set_keymap("n", "<leader>st", "", {
      callback = function() require("aerial").toggle() end,
      desc = "General: [t]oggle document [s]ymbols",
    })
  end,
}
