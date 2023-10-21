return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
    keys = {
      {
        "<leader>ft",
        function() require("neo-tree.command").execute({ source = "filesystem", toggle = true, dir = vim.uv.cwd() }) end,
        desc = "General: [t]oggle the [f]olders explorer",
      },
      {
        "<leader>gt",
        function() require("neo-tree.command").execute({ source = "git_status", toggle = true, dir = vim.uv.cwd() }) end,
        desc = "General: [t]oggle the [g]it status explorer",
      },
      {
        "<leader>st",
        function()
          require("neo-tree.command").execute({ source = "document_symbols", toggle = true, dir = vim.uv.cwd() })
        end,
        desc = "General: [t]oggle the [s]ymbols explorer",
      },
    },
    cmd = "Neotree",
    deactivate = function() require("neo-tree.command").execute({ action = "close" }) end,
    lazy = true,
    init = function()
      require("wuelnerdotexe.plugin.util").add_colorscheme_integration("neo-tree")

      vim.opt.listchars:append({ precedes = "…", extends = "…" })

      vim.api.nvim_set_var("loaded_netrw", 1)
      vim.api.nvim_set_var("loaded_netrwPlugin", 1)
      vim.api.nvim_set_var("loaded_netrwSettings", 1)
      vim.api.nvim_set_var("loaded_netrwFileHandlers", 1)

      vim.list_extend(require("wuelnerdotexe.plugin.util").user_interface_filetypes, { "neo-tree", "neo-tree-popup" })

      if not require("wuelnerdotexe.plugin.util").enter_with_arguments() then return end

      local stat = vim.uv.fs_stat(vim.api.nvim_call_function("argv", { 0 }))

      if not stat or stat.type ~= "directory" then return end

      require("lazy").load({ plugins = { "neo-tree.nvim" } })
    end,
    config = function()
      require("neo-tree").setup({
        sources = { "git_status", "filesystem", "document_symbols" },
        auto_clean_after_session_restore = true,
        enable_diagnostics = false,
        hide_root_node = true,
        open_files_do_not_replace_types = require("wuelnerdotexe.plugin.util").user_interface_filetypes,
        popup_border_style = "rounded",
        resize_timer_interval = 67,
        use_default_mappings = false,
        source_selector = {
          winbar = require("lazy.core.config").spec.plugins["edgy.nvim"] == nil,
          sources = {
            { source = "git_status", display_name = "  GIT STATUS " },
            { source = "filesystem", display_name = " 󰉓 FOLDERS " },
            { source = "document_symbols", display_name = "  SYMBOLS " },
          },
          content_layout = "center",
          separator = "",
          separator_active = { left = "▎", right = "" },
          show_separator_on_edge = true,
        },
        event_handlers = {
          { event = "file_opened", handler = function() require("neo-tree.command").execute({ action = "close" }) end },
          {
            event = "file_renamed",
            handler = function(args)
              for _, client in pairs(vim.lsp.get_clients()) do
                if client.supports_method("workspace/willRenameFiles") then
                  local resp = client.request_sync("workspace/willRenameFiles", {
                    files = {
                      {
                        oldUri = vim.uri_from_fname(args.source),
                        newUri = vim.uri_from_fname(args.destination),
                      },
                    },
                  }, 1000, 0)

                  if resp and resp.result ~= nil then
                    vim.lsp.util.apply_workspace_edit(resp.result, client.offset_encoding)
                  end
                end
              end
            end,
          },
          {
            event = "file_moved",
            handler = function(args)
              for _, client in pairs(vim.lsp.get_clients()) do
                if client.supports_method("workspace/willRenameFiles") then
                  local resp = client.request_sync("workspace/willRenameFiles", {
                    files = {
                      {
                        oldUri = vim.uri_from_fname(args.source),
                        newUri = vim.uri_from_fname(args.destination),
                      },
                    },
                  }, 1000, 0)

                  if resp and resp.result ~= nil then
                    vim.lsp.util.apply_workspace_edit(resp.result, client.offset_encoding)
                  end
                end
              end
            end,
          },
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
          created = { enabled = true },
          symlink_target = { enabled = true },
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
                { "git_status", zindex = 10, align = "right", hide_when_expanded = true },
                { "file_size", zindex = 10, align = "right" },
                { "type", zindex = 10, align = "right" },
                { "last_modified", zindex = 10, align = "right" },
                { "created", zindex = 10, align = "right" },
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
                { "git_status", zindex = 10, align = "right" },
                { "file_size", zindex = 10, align = "right" },
                { "type", zindex = 10, align = "right" },
                { "last_modified", zindex = 10, align = "right" },
                { "created", zindex = 10, align = "right" },
              },
            },
          },
        },
        window = {
          position = "right",
          width = require("wuelnerdotexe.plugin.util").get_sidebar_width(),
          insert_as = "sibling",
          mappings = {
            ["<CR>"] = "open",
            ["<2-LeftMouse>"] = "open",
            ["<localleader>pt"] = { "toggle_preview", config = { use_float = true } },
            ["<C-s>"] = "open_split",
            ["<C-v>"] = "open_vsplit",
            ["<C-t>"] = "open_tabnew",
            ["<F5>"] = "refresh",
            ["a"] = { "add", config = { show_path = "relative" } },
            ["d"] = "delete",
            ["r"] = "rename",
            ["y"] = "copy_to_clipboard",
            ["x"] = "cut_to_clipboard",
            ["p"] = "paste_from_clipboard",
            ["c"] = { "copy", config = { show_path = "relative" } },
            ["m"] = { "move", config = { show_path = "relative" } },
            ["q"] = "close_window",
            ["?"] = "show_help",
            ["gb"] = require("lazy.core.config").spec.plugins["edgy.nvim"] == nil and "next_source" or "noop",
            ["<S-PageDown>"] = require("lazy.core.config").spec.plugins["edgy.nvim"] == nil and "next_source" or "noop",
            ["gB"] = require("lazy.core.config").spec.plugins["edgy.nvim"] == nil and "prev_source" or "noop",
            ["<S-PageUp>"] = require("lazy.core.config").spec.plugins["edgy.nvim"] == nil and "prev_source" or "noop",
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
              ["K"] = "show_file_details",
            },
          },
          filtered_items = {
            hide_dotfiles = false,
            hide_gitignored = false,
            never_show = { ".git", ".svn", ".hg", "CSV", ".DS_Store", "thumbs.db" },
          },
          follow_current_file = { enabled = true },
        },
        git_status = {
          window = {
            mappings = {
              ["gA"] = "git_add_all",
              ["gu"] = "git_unstage_file",
              ["gs"] = "git_add_file",
              ["gr"] = "git_revert_file",
              ["gc"] = "git_commit",
              ["K"] = "show_file_details",
            },
          },
        },
        document_symbols = {
          follow_cursor = true,
          client_filters = "all",
          window = {
            mappings = {
              ["<CR>"] = "toggle_node",
              ["<2-LeftMouse>"] = "toggle_node",
              ["a"] = "noop",
              ["d"] = "noop",
              ["r"] = "noop",
              ["y"] = "noop",
              ["x"] = "noop",
              ["p"] = "noop",
              ["c"] = "noop",
              ["m"] = "noop",
              ["o"] = "jump_to_symbol",
              ["/"] = "filter",
              ["<C-f>"] = "filter_on_submit",
            },
          },
          kinds = {
            File = { icon = "", hl = "@text" },
            Module = { icon = "", hl = "@text" },
            Namespace = { icon = "", hl = "@namespace" },
            Package = { icon = "", hl = "@string" },
            Class = { icon = "", hl = "@type" },
            Method = { icon = "", hl = "@method" },
            Property = { icon = "", hl = "@property" },
            Field = { icon = "", hl = "@field" },
            Constructor = { icon = " ", hl = "@constructor" },
            Enum = { icon = "", hl = "@type" },
            Interface = { icon = "", hl = "@type" },
            Function = { icon = "", hl = "@function" },
            Variable = { icon = "", hl = "@variable" },
            Constant = { icon = "", hl = "@constant" },
            String = { icon = "", hl = "@string" },
            Number = { icon = "", hl = "@number" },
            Boolean = { icon = "", hl = "@boolean" },
            Array = { icon = "", hl = "@variable" },
            Object = { icon = "", hl = "@type" },
            Key = { icon = "", hl = "@variable" },
            Null = { icon = "ﳠ", hl = "@boolean" },
            EnumMember = { icon = "", hl = "@property" },
            Struct = { icon = "", hl = "@type" },
            Event = { icon = "", hl = "@variable.builtin" },
            Operator = { icon = "", hl = "@operator" },
            TypeParameter = { icon = "", hl = "@type" },
          },
        },
      })
    end,
  },
  {
    "akinsho/bufferline.nvim",
    optional = true,
    opts = function(_, opts)
      opts.options = opts.options or {}

      opts.options.offsets = vim.list_extend(opts.options.offsets or {}, {
        { filetype = "neo-tree", text = "SIDEBAR", highlight = "Ignore", separator = false },
      })
    end,
  },
  {
    "folke/edgy.nvim",
    optional = true,
    ft = "neo-tree",
    opts = function(_, opts)
      opts.right = vim.list_extend(opts.right or {}, {
        {
          ft = "neo-tree",
          filter = function(buf) return vim.api.nvim_buf_get_var(buf, "neo_tree_source") == "git_status" end,
          open = function()
            require("neo-tree.command").execute({ source = "git_status", position = "left", dir = vim.uv.cwd() })
          end,
          title = "GIT STATUS",
          size = { width = function() return require("wuelnerdotexe.plugin.util").get_sidebar_width() end },
          pinned = true,
        },
        {
          ft = "neo-tree",
          filter = function(buf) return vim.api.nvim_buf_get_var(buf, "neo_tree_source") == "filesystem" end,
          open = function()
            require("neo-tree.command").execute({ source = "filesystem", position = "top", dir = vim.uv.cwd() })
          end,
          title = "FOLDERS",
          size = { width = function() return require("wuelnerdotexe.plugin.util").get_sidebar_width() end },
          pinned = true,
        },
        {
          ft = "neo-tree",
          filter = function(buf) return vim.api.nvim_buf_get_var(buf, "neo_tree_source") == "document_symbols" end,
          open = function()
            require("neo-tree.command").execute({ source = "document_symbols", position = "bottom", dir = vim.uv.cwd() })
          end,
          title = "SYMBOLS",
          size = { width = function() return require("wuelnerdotexe.plugin.util").get_sidebar_width() end },
          pinned = true,
        },
      })
    end,
  },
}
