return {
  "nvim-tree/nvim-web-devicons",
  lazy = true,
  init = function() require("wuelnerdotexe.plugin.util").set_option("termguicolors", true) end,
  config = function() require("nvim-web-devicons").setup({ default = true }) end,
}
