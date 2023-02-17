return {
  "wuelnerdotexe/vim-enfocado",
  lazy = false,
  priority = 1000,
  init = function()
    vim.api.nvim_set_option_value("termguicolors", true, require("wuelnerdotexe.utils").empty_table)
    vim.api.nvim_set_option_value("t_Co", 256, require("wuelnerdotexe.utils").empty_table)
    vim.api.nvim_set_option_value("background", "dark", require("wuelnerdotexe.utils").empty_table)

    vim.api.nvim_set_var("enfocado_plugins", {
      "aerial",
      "bufferline",
      "cmp",
      "dap-ui",
      "fern",
      "gitsigns",
      "glyph-palette",
      "illuminate",
      "indent-blankline",
      "lazy",
      "lspconfig",
      "matchup",
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

    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "enfocado",
      callback = function()
        vim.api.nvim_set_option_value(
          "winblend",
          require("wuelnerdotexe.utils").interface.blend,
          require("wuelnerdotexe.utils").empty_table
        )

        vim.api.nvim_set_option_value(
          "pumblend",
          require("wuelnerdotexe.utils").interface.blend,
          require("wuelnerdotexe.utils").empty_table
        )

        local fillchars = vim.api.nvim_get_option_value("fillchars", require("wuelnerdotexe.utils").empty_table)

        vim.api.nvim_set_option_value(
          "fillchars",
          fillchars == "" and "vert: ,horiz: ,verthoriz: ,vertleft: ,horizdown: ,horizup: ,vertright: "
            or fillchars .. ",vert: ,horiz: ,verthoriz: ,vertleft: ,horizdown: ,horizup: ,vertright: ",
          require("wuelnerdotexe.utils").empty_table
        )

        vim.api.nvim_command("highlight NormalNC guibg=#1e1e1e")
        vim.api.nvim_command("highlight NormalSB guibg=#000000 guifg=#b9b9b9")
        vim.api.nvim_command("highlight WinbarSB guibg=#000000 guifg=#000000")
        vim.api.nvim_command("highlight! link Whitespace DiagnosticError")

        vim.api.nvim_create_autocmd("FileType", {
          pattern = "aerial,fern,nerdterm,qf",
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
  end,
  config = function() vim.api.nvim_command("colorscheme enfocado") end,
}
