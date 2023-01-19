return {
  "stevearc/aerial.nvim",
  event = { "BufNewFile", "BufReadPre" },
  config = function()
    vim.api.nvim_set_option_value("foldmethod", "manual", {})

    local columns = vim.api.nvim_get_option_value("columns", {})
    local layout_width = math.floor((columns / (columns >= 160 and 3 or 2)) / 2)
    local buf_set_keymap = vim.api.nvim_buf_set_keymap
    local command = vim.api.nvim_command

    require("aerial").setup({
      layout = {
        max_width = layout_width,
        width = layout_width,
        min_width = layout_width,
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
      disable_max_size = 102400,
      filter_kind = false,
      highlight_mode = "last",
      highlight_closest = false,
      highlight_on_jump = 125,
      icons = {
        Array = "",
        Boolean = "",
        Class = "",
        Constant = "",
        Constructor = "",
        Enum = "",
        EnumMember = "",
        Event = "",
        Field = "",
        File = "",
        Function = "",
        Interface = "",
        Key = "",
        Method = "",
        Module = "",
        Namespace = "",
        Null = "ﳠ",
        Number = "",
        Object = "",
        Operator = "",
        Package = "",
        Property = "",
        String = "",
        Struct = "",
        TypeParameter = "",
        Variable = "",
      },
      manage_folds = "auto",
      link_folds_to_tree = true,
      link_tree_to_folds = true,
      on_attach = function(bufnr)
        buf_set_keymap(bufnr, "n", "{", "", {
          callback = function()
            command("AerialPrev")
          end,
        })

        buf_set_keymap(bufnr, "n", "}", "", {
          callback = function()
            command("AerialNext")
          end,
        })
      end,
      show_guides = true,
      guides = { mid_item = "│ ", last_item = "└ ", nested_top = "│ " },
      float = { border = "rounded", relative = "editor" },
    })

    vim.api.nvim_set_keymap("n", "<leader>st", "", {
      callback = function()
        require("aerial").toggle()
      end,
    })
  end,
}
