return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  lazy = false,
  dependencies = { "mrjones2014/nvim-ts-rainbow", "windwp/nvim-ts-autotag" },
  config = function()
    local results = {}

    setmetatable(results, { __mode = "kv" })

    require("nvim-treesitter.configs").setup({
      context_commentstring = { enable = true, enable_autocmd = false },
      ensure_installed = { "bash", "comment", "lua", "markdown", "markdown_inline", "regex", "vim" },
      sync_install = true,
      auto_install = true,
      highlight = {
        enable = true,
        disable = function(_, buf)
          local results_buf = results[buf]

          if results_buf then
            return results_buf
          else
            local stats = vim.loop.fs_stat(vim.api.nvim_buf_get_name(buf))

            if stats and stats.size > 100000 then
              results[buf] = true

              return true
            end
          end
        end,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gnn",
          node_incremental = "grn",
          scope_incremental = "grc",
          node_decremental = "grm",
        },
      },
      rainbow = { enable = true, extended_mode = false, max_file_lines = 400 },
      autotag = { enable = true },
      matchup = { enable = true, include_match_words = true },
    })
  end,
}
