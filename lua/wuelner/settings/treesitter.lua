local M = {}

M.config = function()
  require("nvim-treesitter.configs").setup({
    ensure_installed = "comment",
    sync_install = true,
    auto_install = true,
    highlight = {
      enable = true,
      disable = function(lang, buf)
        local max_filesize = 100 * 1024
        local ok, stats = pcall(
          vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf)
        )

        if ok and stats and stats.size > max_filesize then
          return true
        end
      end,
      additional_vim_regex_highlighting = false
    },
    indent = { enable = true },
    rainbow = { enable = true, extended_mode = false, max_file_lines = nil },
    context_commentstring = { enable = true, enable_autocmd = false },
    autotag = { enable = true },
    matchup = { enable = true },
  })

  local vim_opt = vim.opt

  vim_opt.foldmethod = "expr"
  vim_opt.foldexpr = "nvim_treesitter#foldexpr()"
end

return M
