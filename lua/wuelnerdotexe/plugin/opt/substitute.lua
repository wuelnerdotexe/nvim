return {
  "gbprod/substitute.nvim",
  enabled = not require("wuelnerdotexe.plugin.config").minimal_setup,
  keys = {
    { "s", function() require("substitute").operator() end },
    { "ss", function() require("substitute").line() end },
    { "S", function() require("substitute").eol() end },
    { "s", function() require("substitute").visual() end, mode = "x" },
    { "sx", function() require("substitute.exchange").operator() end },
    { "sxx", function() require("substitute.exchange").line() end },
    { "X", function() require("substitute.exchange").visual() end, mode = "x" },
  },
  dependencies = "gbprod/yanky.nvim",
  config = function() require("substitute").setup({ on_substitute = require("yanky.integration").substitute() }) end,
}
