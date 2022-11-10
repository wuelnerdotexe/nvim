local M = {}

M.config = function()
  local o_columns = vim.o.columns
  local layout_width =
    math.floor((o_columns / (o_columns >= 160 and 3 or 2)) / 2)

  require("aerial").setup({
    backends = { "lsp", "treesitter", "markdown", "man" },
    layout = {
      max_width = layout_width,
      width = layout_width,
      min_width = layout_width,
      default_direction = "right",
      placement = "edge",
    },
    attach_mode = "global",
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
    on_attach = function(bufnr)
      local keymap_set = vim.keymap.set

      keymap_set("n", "{", "<Cmd>AerialPrev<CR>", { buffer = bufnr })
      keymap_set("n", "}", "<Cmd>AerialNext<CR>", { buffer = bufnr })
    end,
    show_guides = true,
    guides = { mid_item = "│ ", last_item = "└ ", nested_top = "│ " },
    float = { border = "rounded", relative = "editor" },
  })

  vim.keymap.set("n", "<leader>st", require("aerial").toggle)
end

return M
