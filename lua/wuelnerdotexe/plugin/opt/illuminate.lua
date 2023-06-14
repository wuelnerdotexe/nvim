return {
  "RRethy/vim-illuminate",
  keys = { "<C-n>", "<A-p>", "<A-i>" },
  cmd = {
    "IlluminateDebug",
    "IlluminatePause",
    "IlluminatePauseBuf",
    "IlluminateResume",
    "IlluminateResumeBuf",
    "IlluminateToggle",
    "IlluminateToggleBuf",
  },
  event = "FileType",
  config = function()
    require("illuminate").configure({
      delay = 42,
      filetypes_denylist = vim.list_extend({ "" }, require("wuelnerdotexe.plugin.config").uifiletypes),
      max_file_lines = 400,
    })
  end,
}
