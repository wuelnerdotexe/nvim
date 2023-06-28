return {
  "kylechui/nvim-surround",
  keys = {
    { "ys" },
    { "yS" },
    { "ds" },
    { "cs" },
    { "gS", mode = "x" },
    { "S", mode = "x" },
    { "<C-g>s", mode = "i" },
    { "<C-g>S", mode = "i" },
  },
  init = function() require("wuelnerdotexe.plugin.util").add_colorscheme_integration("surround") end,
  config = function() require("nvim-surround").setup() end,
}
