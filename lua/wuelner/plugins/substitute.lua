return {
  "gbprod/substitute.nvim",
  keys = {
    {
      "s",
      function()
        require("substitute").operator()
      end,
    },
    {
      "ss",
      function()
        require("substitute").line()
      end,
    },
    {
      "S",
      function()
        require("substitute").eol()
      end,
    },
    {
      "s",
      function()
        require("substitute").visual()
      end,
      mode = "x",
    },
    {
      "sx",
      function()
        require("substitute.exchange").operator()
      end,
    },
    {
      "sxx",
      function()
        require("substitute.exchange").line()
      end,
    },
    {
      "X",
      function()
        require("substitute.exchange").visual()
      end,
      mode = "x",
    },
    {
      "X",
      function()
        require("substitute.exchange").visual()
      end,
      mode = "x",
    },
  },
  config = function()
    require("substitute").setup({ on_substitute = require("yanky.integration").substitute() })
  end,
}
