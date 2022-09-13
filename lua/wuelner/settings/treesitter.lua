local M = {}

M.config = function()
  require('nvim-treesitter.configs').setup({
    ensure_installed = 'comment',
    sync_install = true,
    auto_install = true,
    highlight = { enable = true, additional_vim_regex_highlighting = false },
    indent = { enable = true },
    rainbow = { enable = true, extended_mode = false, max_file_lines = nil },
    context_commentstring = {
      enable = true,
      commentary_integration = { Commentary = 'g/', CommentaryLine = false }
    },
    autotag = { enable = true },
    matchup = { enable = true }
  })
end

return M

