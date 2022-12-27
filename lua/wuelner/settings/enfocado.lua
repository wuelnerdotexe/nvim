local M = {}

M.setup = function()
  local set_var = vim.api.nvim_set_var

  set_var("enfocado_style", "nature")
  set_var("enfocado_plugins", {
    "aerial",
    "bufferline",
    "cmp",
    "dap-ui",
    "fern",
    "fzf",
    "gitsigns",
    "glyph-palette",
    "illuminate",
    "indent-blankline",
    "lspconfig",
    "matchup",
    "noice",
    "notify",
    "null-ls",
    "packer",
    "smoothcursor",
    "telescope",
    "treesitter",
    "visual-multi",
  })
end

M.config = function()
  local create_autocmd = vim.api.nvim_create_autocmd

  create_autocmd("ColorScheme", {
    pattern = "enfocado",
    nested = true,
    callback = function()
      local set_option_value = vim.api.nvim_set_option_value
      local get_option_value = vim.api.nvim_get_option_value
      local option_opts = {}

      set_option_value(
        "fillchars",
        get_option_value("fillchars", option_opts)
          .. ",vert: ,horiz: ,verthoriz: ,vertleft: ,horizdown: ,horizup: ,vertright: ",
        option_opts
      )

      vim.cmd([[
      highlight NormalNC guibg=#1e1e1e

      highlight default NormalSB guibg=#000000 guifg=#b9b9b9
      highlight default WinbarSB guibg=#000000 guifg=#000000

      highlight! link Whitespace DiagnosticError
      ]])

      create_autocmd("FileType", {
        pattern = "fern,aerial,nerdterm,qf",
        callback = function(ev)
          set_option_value(
            "winhighlight",
            "Normal:NormalSB,NormalNC:NormalSB,Winbar:WinbarSB,WinbarNC:WinbarSB",
            { buf = ev.buf }
          )
        end,
      })

      if
        vim.api.nvim_call_function("has", { "termguicolors" }) == 1
        and get_option_value("termguicolors", option_opts) == true
      then
        set_option_value("winblend", 10, option_opts)
        set_option_value("pumblend", 10, option_opts)
      end
    end,
  })
end

return M
