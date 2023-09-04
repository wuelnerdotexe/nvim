return {
  "nacro90/numb.nvim",
  event = "CmdlineEnter",
  config = function() require("numb").setup() end,
}
