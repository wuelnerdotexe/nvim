local M = {}

M.config = function()
  require("nvim-treesitter.configs").setup({
    ensure_installed = "comment",
    sync_install = true,
    auto_install = true,
    highlight = {
      enable = true,
      disable = function(lang, buf)
        local vim = vim
        local ok, stats =
          pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))

        if ok and stats and stats.size > 100 * 1024 then
          return true
        end
      end,
      additional_vim_regex_highlighting = false,
    },
    indent = { enable = true },
    rainbow = { enable = true, extended_mode = false, max_file_lines = nil },
    context_commentstring = { enable = true, enable_autocmd = false },
    autotag = { enable = true },
  })
end

return M
