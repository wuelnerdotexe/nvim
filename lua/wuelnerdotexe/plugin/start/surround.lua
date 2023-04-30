return {
  "kylechui/nvim-surround",
  dependencies = "nvim-treesitter/nvim-treesitter",
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
  config = function() require("nvim-surround").setup() end,
}
