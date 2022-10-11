local M = {}

M.config = function()
  require("aerial").setup({
    backends = { "lsp", "treesitter", "markdown" },
    layout = {
      max_width = 26,
      width = 26,
      min_width = 26,
      default_direction = "right",
      placement = "edge",
    },
    attach_mode = "global",
    disable_max_size = 1024 * 1024,
    highlight_mode = "last",
    highlight_closest = false,
    highlight_on_jump = 125,
    on_attach = function(bufnr)
      local keymap_set = vim.keymap.set

      keymap_set("n", "<leader>st", "<Cmd>AerialToggle!<CR>", {
        buffer = bufnr,
      })

      keymap_set("n", "[s", "<Cmd>AerialPrev<CR>", {
        buffer = bufnr,
      })

      keymap_set("n", "]s", "<Cmd>AerialNext<CR>", {
        buffer = bufnr,
      })
    end,
    show_guides = true,
    float = { border = "single", relative = "editor" },
  })
end

return M
