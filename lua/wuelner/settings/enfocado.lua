local M = {}

M.setup = function()
  vim.g.enfocado_style = "nature"
  vim.g.enfocado_plugins = {
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
  }
end

M.config = function()
  local create_autocmd = vim.api.nvim_create_autocmd

  vim.api.nvim_create_augroup("EnfocadoSB", {})

  create_autocmd("ColorScheme", {
    pattern = "enfocado",
    nested = true,
    callback = function()
      local set_hl = vim.api.nvim_set_hl

      set_hl(0, "Whitespace", { link = "DiagnosticError" })
      set_hl(0, "NormalSB", { bg = "#000000", fg = "#b9b9b9" })
      set_hl(0, "WinbarSB", { bg = "#000000", fg = "#000000" })

      vim.api.nvim_clear_autocmds({ group = "EnfocadoSB" })
      create_autocmd("FileType", {
        group = "EnfocadoSB",
        pattern = "fern,aerial,nerdterm,qf",
        command = "setlocal winhighlight="
          .. "Normal:NormalSB,NormalNC:NormalSB,"
          .. "Winbar:WinbarSB,WinbarNC:WinbarSB",
      })

      if
        vim.fn.has("termguicolors") and vim.opt.termguicolors:get() == true
      then
        vim.opt.winblend = 10
        vim.opt.pumblend = 10
      end
    end,
  })
end

return M
