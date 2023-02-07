return {
  "wuelnerdotexe/vim-enfocado",
  lazy = false,
  priority = 1000,
  init = function()
    local option_opts = {}

    vim.api.nvim_set_option_value("termguicolors", true, option_opts)
    vim.api.nvim_set_option_value("t_Co", 256, option_opts)
    vim.api.nvim_set_option_value("background", "dark", option_opts)

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
        vim.api.nvim_command("highlight NormalNC guibg=#1e1e1e")
        vim.api.nvim_command("highlight NormalSB guibg=#000000 guifg=#b9b9b9")
        vim.api.nvim_command("highlight WinbarSB guibg=#000000 guifg=#000000")
        vim.api.nvim_command("highlight! link Whitespace DiagnosticError")

        if
          vim.api.nvim_call_function("has", { "termguicolors" }) == 1
          and vim.api.nvim_get_option_value("termguicolors", option_opts) == true
        then
          vim.api.nvim_set_option_value("winblend", 10, option_opts)
          vim.api.nvim_set_option_value("pumblend", 10, option_opts)
        end

        local fillchars = vim.api.nvim_get_option_value("fillchars", option_opts)

        vim.api.nvim_set_option_value(
          "fillchars",
          fillchars == "" and "vert: ,horiz: ,verthoriz: ,vertleft: ,horizdown: ,horizup: ,vertright: "
            or fillchars .. ",vert: ,horiz: ,verthoriz: ,vertleft: ,horizdown: ,horizup: ,vertright: ",
          option_opts
        )

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
  config = function()
    vim.api.nvim_command("colorscheme enfocado")
  end,
}
