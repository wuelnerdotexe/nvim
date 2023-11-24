return {
  "backdround/improved-search.nvim",
  keys = {
    { "!", function() require("improved-search").current_word() end },
    { "!", function() require("improved-search").in_place() end, mode = "x" },
    { "#", function() require("improved-search").backward() end, mode = "x" },
    { "*", function() require("improved-search").forward() end, mode = "x" },
    { "N", function() require("improved-search").stable_previous() end, mode = { "n", "x", "o" } },
    { "n", function() require("improved-search").stable_next() end, mode = { "n", "x", "o" } },
  },
}
