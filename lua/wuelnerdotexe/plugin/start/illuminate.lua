return {
  "RRethy/vim-illuminate",
  event = require("wuelnerdotexe.utils").plugins.open_file_event,
  config = function()
    require("illuminate").configure({
      delay = 42,
      filetypes_denylist = require("wuelnerdotexe.utils").interface.filetypes,
      max_file_lines = 400,
    })
  end,
}
