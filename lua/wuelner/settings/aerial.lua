local M = {}

M.config = function()
  vim.opt.foldmethod = "manual"
  vim.opt.foldlevelstart = 99

  local columns = vim.opt.columns:get()
  local layout_width = math.floor((columns / (columns >= 160 and 3 or 2)) / 2)
  local keymap_set = vim.keymap.set

  require("aerial").setup({
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
    manage_folds = "auto",
    link_folds_to_tree = true,
    link_tree_to_folds = true,
    on_attach = function(bufnr)
      local keymap_opts = { buffer = bufnr }

      keymap_set("n", "{", "<Cmd>AerialPrev<CR>", keymap_opts)
      keymap_set("n", "}", "<Cmd>AerialNext<CR>", keymap_opts)
    end,
    show_guides = true,
    guides = { mid_item = "│ ", last_item = "└ ", nested_top = "│ " },
    float = { border = "rounded", relative = "editor" },
  })

  vim.api.nvim_create_autocmd("Filetype", { pattern = "aerial", command = "setlocal signcolumn=yes:1" })

  keymap_set("n", "<leader>st", require("aerial").toggle)
end

return M
