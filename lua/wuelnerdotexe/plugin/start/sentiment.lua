return {
  "utilyre/sentiment.nvim",
  event = require("wuelnerdotexe.plugin.config").open_file_event,
  init = function()
    vim.api.nvim_set_var("loaded_matchparen", 1)

    require("wuelnerdotexe.plugin.util").set_option("showmatch", true)
    require("wuelnerdotexe.plugin.util").set_option("matchtime", 4)
    require("wuelnerdotexe.plugin.util").set_option("matchpairs", "(:),{:},[:],<:>")
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
      excluded_filetypes = require("wuelnerdotexe.plugin.config").uifiletypes,
      delay = 42,
      limit = 400,
      pairs = { { "(", ")" }, { "{", "}" }, { "[", "]" }, { "<", ">" } },
    })
  end,
}
