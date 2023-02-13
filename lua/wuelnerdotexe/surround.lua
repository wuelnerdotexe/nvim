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
  config = function()
    require("nvim-surround").setup()
  end,
}
