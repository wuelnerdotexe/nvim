return {
  "utilyre/sentiment.nvim",
  cmd = { "DoMatchParen", "NoMatchParen" },
  event = "FileType",
  init = function()
    require("wuelnerdotexe.plugin.util").set_option("showmatch", true)
    require("wuelnerdotexe.plugin.util").set_option("matchtime", 4)
    require("wuelnerdotexe.plugin.util").set_option("matchpairs", "(:),{:},[:],<:>")

    vim.api.nvim_set_var("loaded_matchparen", 1)
  end,
  config = function()
    require("sentiment").setup({
      included_buftypes = {
        help = false,
        loclist = false,
        nofile = false,
        prompt = false,
        quickfix = false,
        terminal = false,
      },
      excluded_filetypes = vim.list_extend({ "", "list" }, require("wuelnerdotexe.plugin.config").uifiletypes),
      delay = 42,
      limit = 400,
      pairs = { { "(", ")" }, { "{", "}" }, { "[", "]" }, { "<", ">" } },
    })
  end,
}
