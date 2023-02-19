return {
  "RRethy/vim-illuminate",
  event = require("wuelnerdotexe.plugin.configs").open_file_event,
  config = function()
    require("illuminate").configure({
      delay = 42,
      filetypes_denylist = require("wuelnerdotexe.plugin.configs").uifiletypes,
      max_file_lines = 400,
    })
  end,
}
