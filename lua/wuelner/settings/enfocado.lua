local M = {}

M.setup = function()
  vim.g.enfocado_style = "nature"
  vim.g.enfocado_plugins = {
    "aerial",
    "bufferline",
    "cmp",
    "dapui",
    "fern",
    "fzf",
    "gitsigns",
    "glyph-palette",
    "illuminate",
    "indent-blankline",
    "lsp",
    "matchup",
    "noice",
    "notify",
    "packer",
    "smoothcursor",
    "telescope",
    "treesitter",
    "visual-multi",
  }
end

M.config = function()
  local create_autocmd = vim.api.nvim_create_autocmd

  vim.api.nvim_create_augroup("EnfocadoSB", {})

  create_autocmd("ColorScheme", {
    pattern = "enfocado",
    nested = true,
    callback = function()
      local vim_cmd = vim.cmd

      vim_cmd("hi! link Whitespace DiagnosticError")

      if vim.o.background == "dark" then
        vim_cmd([[
          hi def NormalSB ctermbg=16 ctermfg=250 guibg=#000000 guifg=#b9b9b9
          hi def WinbarSB ctermbg=16 ctermfg=16 guibg=#000000 guifg=#000000
        ]])
      else
        vim_cmd([[
          hi def NormalSB ctermbg=255 ctermfg=238 guibg=#ebebeb guifg=#474747
          hi def WinbarSB ctermbg=255 ctermfg=255 guibg=#ebebeb guifg=#ebebeb
        ]])
      end

      vim.api.nvim_clear_autocmds({ group = "EnfocadoSB" })
      create_autocmd("FileType", {
        group = "EnfocadoSB",
        pattern = "fern,aerial,nerdterm,qf",
        command = "setlocal winhighlight="
          .. "Normal:NormalSB,NormalNC:NormalSB,"
          .. "Winbar:WinbarSB,WinbarNC:WinbarSB",
      })

      if vim.fn.has("termguicolors") and vim.o.termguicolors == true then
        vim.opt.winblend = 10
        vim.opt.pumblend = 10
      end
    end,
  })
end

return M
