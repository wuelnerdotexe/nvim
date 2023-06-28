return {
  "utilyre/sentiment.nvim",
  cmd = { "DoMatchParen", "NoMatchParen" },
  event = "FileType",
  init = function()
    require("wuelnerdotexe.plugin.util").set_option("showmatch", true)
    require("wuelnerdotexe.plugin.util").set_option("matchpairs", "(:),{:},[:],<:>")

    vim.api.nvim_set_var("loaded_matchparen", 1)
  end,
  config = function()
    require("sentiment").setup({
      excluded_filetypes = { "netrw" },
      included_modes = {
        ["i"] = false,
        ["n"] = true,
        ["c"] = true,
        ["r"] = true,
        ["R"] = true,
        ["s"] = true,
        ["S"] = true,
        ["v"] = true,
        ["V"] = true,
        ["\22"] = true,
      },
      delay = vim.api.nvim_get_option_value("matchtime", { scope = "global" }) * 100,
      limit = 400,
      pairs = { { "(", ")" }, { "{", "}" }, { "[", "]" }, { "<", ">" } },
    })
  end,
}
