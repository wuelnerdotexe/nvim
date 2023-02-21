return {
  "RRethy/vim-illuminate",
  event = require("wuelnerdotexe.plugin.config").open_file_event,
  config = function()
    require("illuminate").configure({
      delay = 42,
      filetypes_denylist = require("wuelnerdotexe.plugin.config").uifiletypes,
      max_file_lines = 400,
    })
  end,
}
