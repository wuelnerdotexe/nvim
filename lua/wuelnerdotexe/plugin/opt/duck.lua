return {
  "tamton-aquib/duck.nvim",
  enabled = not require("wuelnerdotexe.plugin.config").minimal_setup,
  keys = {
    { "<leader>dh", function() require("duck").hatch() end },
    { "<leader>dc", function() require("duck").cook() end },
  },
}
