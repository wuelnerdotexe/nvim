return {
  "tamton-aquib/duck.nvim",
  keys = {
    { "<leader>dh", function() require("duck").hatch() end, desc = "Duck: [h]atch a [d]uck" },
    { "<leader>dc", function() require("duck").cook() end, desc = "Pets: [c]ook a [d]uck" },
  },
}
