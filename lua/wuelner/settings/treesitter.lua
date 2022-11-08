local M = {}

M.config = function()
  require("nvim-treesitter.configs").setup({
    ensure_installed = "comment",
    sync_install = true,
    auto_install = true,
    highlight = {
      enable = true,
      disable = function(lang, buf)
        local ok, stats =
          pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))

        if ok and stats and stats.size > 102400 then
          return true
        end
      end,
      additional_vim_regex_highlighting = false,
    },
    indent = { enable = true },
    rainbow = { enable = true, extended_mode = false, max_file_lines = 400 },
    context_commentstring = { enable = true, enable_autocmd = false },
    autotag = { enable = true },
    matchup = { enable = true, include_match_words = true },
  })

  vim.opt.foldmethod = "expr"
  vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
  vim.opt.foldenable = false
end

return M
