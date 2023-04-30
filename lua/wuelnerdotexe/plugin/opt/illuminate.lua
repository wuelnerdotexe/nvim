return {
  "RRethy/vim-illuminate",
  enabled = not require("wuelnerdotexe.plugin.config").minimal_setup,
  event = require("wuelnerdotexe.plugin.config").open_file_event,
  dependencies = "nvim-treesitter/nvim-treesitter",
  config = function()
    require("illuminate").configure({
      delay = 42,
      filetypes_denylist = require("wuelnerdotexe.plugin.config").uifiletypes,
      max_file_lines = 400,
    })
  end,
}
