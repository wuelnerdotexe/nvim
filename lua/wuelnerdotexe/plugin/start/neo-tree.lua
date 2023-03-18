return {
  "nvim-neo-tree/neo-tree.nvim",
  cmd = "Neotree",
  keys = {
    { "<leader>ft", function() vim.api.nvim_command("Neotree . filesystem reveal toggle") end },
    { "<leader>gt", function() vim.api.nvim_command("Neotree . git_status reveal toggle") end },
  },
  dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim" },
  deactivate = function() vim.api.nvim_command("Neotree close") end,
  init = function()
    vim.api.nvim_set_var("neo_tree_remove_legacy_commands", 1)

    if require("wuelnerdotexe.plugin.util").enter_with_args() then
      local stat = vim.loop.fs_stat(vim.api.nvim_call_function("argv", { 0 }))

      if stat and stat.type == "directory" then require("lazy").load({ plugins = { "neo-tree.nvim" } }) end
    end
  end,
  config = function()
    local border = require("wuelnerdotexe.plugin.util").get_border()
    local show_path = { show_path = "relative" }

    require("neo-tree").setup({
      sources = { "filesystem", "git_status" },
      add_blank_line_at_top = true,
      enable_diagnostics = false,
      hide_root_node = true,
      popup_border_style = border.enabled and border.style or border.chars,
      resize_timer_interval = 42,
      use_default_mappings = false,
      source_selector = {
        winbar = true,
        tab_labels = { filesystem = " 󰉓 Folders ", git_status = "  Git Control " },
        content_layout = "center",
        separator = "",
        separator_active = { left = "▎", right = "" },
        show_separator_on_edge = true,
      },
      default_component_configs = {
        container = { right_padding = 1 },
        icon = {
          folder_closed = "",
          folder_open = "",
          folder_empty = "",
          folder_empty_open = "",
          default = "",
        },
        modified = { symbol = "●" },
        git_status = {
          symbols = { added = "A", deleted = "D", modified = "M", renamed = "R", untracked = "?", ignored = "!" },
        },
      },
      renderers = {
        directory = {
          { "indent" },
          { "icon" },
          { "current_filter" },
          {
            "container",
            content = {
              { "name", zindex = 10 },
              { "symlink_target", zindex = 10, highlight = "NeoTreeSymbolicLinkTarget" },
              { "clipboard", zindex = 10 },
              { "git_status", zindex = 20, align = "right", hide_when_expanded = true },
            },
          },
        },
        file = {
          { "indent" },
          { "icon" },
          {
            "container",
            content = {
              { "name", zindex = 10 },
              { "symlink_target", zindex = 10, highlight = "NeoTreeSymbolicLinkTarget" },
              { "clipboard", zindex = 10 },
              { "modified", zindex = 20, align = "right" },
              { "git_status", zindex = 20, align = "right" },
            },
          },
        },
      },
      window = {
        width = require("wuelnerdotexe.plugin.util").get_sidebar_width(),
        auto_expand_width = true,
        insert_as = "sibling",
        mappings = {
          ["<CR>"] = "open",
          ["<2-LeftMouse>"] = "open",
          ["<localleader>pt"] = { "toggle_preview", config = { use_float = true } },
          ["<C-s>"] = "open_split",
          ["<C-v>"] = "open_vsplit",
          ["<C-t>"] = "open_tabnew",
          ["<F5>"] = "refresh",
          ["a"] = { "add", config = show_path },
          ["d"] = "delete",
          ["r"] = "rename",
          ["y"] = "copy_to_clipboard",
          ["x"] = "cut_to_clipboard",
          ["p"] = "paste_from_clipboard",
          ["c"] = { "copy", config = show_path },
          ["m"] = { "move", config = show_path },
          ["q"] = "close_window",
          ["?"] = "show_help",
          ["g?"] = "show_help",
          ["gb"] = "next_source",
          ["<S-PageDown>"] = "next_source",
          ["gB"] = "prev_source",
          ["<S-PageUp>"] = "prev_source",
        },
      },
      filesystem = {
        window = {
          mappings = {
            ["/"] = "fuzzy_finder",
            ["<C-f>"] = "filter_on_submit",
            ["<Esc>"] = "clear_filter",
            ["<"] = "navigate_up",
            [">"] = "set_root",
            ["[g"] = "prev_git_modified",
            ["]g"] = "next_git_modified",
          },
        },
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
          never_show = require("wuelnerdotexe.plugin.config").exclude_explorer_files,
        },
        follow_current_file = true,
      },
      git_status = {
        window = {
          mappings = {
            ["gA"] = "git_add_all",
            ["gu"] = "git_unstage_file",
            ["gs"] = "git_add_file",
            ["gr"] = "git_revert_file",
            ["gc"] = "git_commit",
          },
        },
      },
    })
  end,
}
