return {
  "wuelnerdotexe/vim-enfocado",
  lazy = false,
  priority = 1000,
  init = function()
    vim.api.nvim_set_option_value("termguicolors", true, TBL)
    vim.api.nvim_set_option_value("t_Co", 256, TBL)
    vim.api.nvim_set_option_value("background", "dark", TBL)

    vim.api.nvim_set_var("enfocado_plugins", {
      "aerial",
      "bufferline",
      "cmp",
      "dap-ui",
      "gitsigns",
      "illuminate",
      "indent-blankline",
      "lazy",
      "lspconfig",
      "matchup",
      "neo-tree",
      "noice",
      "null-ls",
      "smoothcursor",
      "substitute",
      "surround",
      "telescope",
      "treesitter",
      "visual-multi",
      "yanky",
    })
  end,
  config = function()
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "enfocado",
      callback = function()
        vim.api.nvim_set_option_value("winblend", require("wuelnerdotexe.plugin.config").blend, TBL)
        vim.api.nvim_set_option_value("pumblend", require("wuelnerdotexe.plugin.config").blend, TBL)

        local fillchars = vim.api.nvim_get_option_value("fillchars", TBL)

        vim.api.nvim_set_option_value(
          "fillchars",
          fillchars == "" and "vert: ,horiz: ,verthoriz: ,vertleft: ,horizdown: ,horizup: ,vertright: "
            or fillchars .. ",vert: ,horiz: ,verthoriz: ,vertleft: ,horizdown: ,horizup: ,vertright: ",
          TBL
        )

        vim.api.nvim_command("highlight NormalNC guibg=#1e1e1e")
        vim.api.nvim_command("highlight NormalSB guibg=#000000 guifg=#b9b9b9")
        vim.api.nvim_command("highlight WinbarSB guibg=#000000 guifg=#000000")
        vim.api.nvim_command("highlight! link NeoTreeNormal NormalSB")
        vim.api.nvim_command("highlight! link NeoTreeNormalNC NormalSB")
        vim.api.nvim_command("highlight! link Whitespace DiagnosticError")

        vim.api.nvim_create_autocmd("FileType", {
          pattern = "aerial,nerdterm,qf",
          callback = function(ev)
            vim.api.nvim_set_option_value(
              "winhighlight",
              vim.api.nvim_get_option_value("filetype", { buf = ev.buf }) == "nerdterm"
                  and "Normal:NormalSB,NormalNC:NormalSB,Winbar:WinbarSB,WinbarNC:WinbarSB"
                or "Normal:NormalSB,NormalNC:NormalSB",
              { buf = ev.buf }
            )
          end,
        })
      end,
    })

    vim.api.nvim_command("colorscheme enfocado")
  end,
}
