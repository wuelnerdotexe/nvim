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
  init = function() require("wuelnerdotexe.plugin.util").add_colorscheme_integration("illuminate") end,
  config = function()
    require("illuminate").configure({
      delay = vim.api.nvim_get_option_value("updatetime", { scope = "global" }),
      filetypes_denylist = vim.list_extend({ "" }, require("wuelnerdotexe.plugin.util").user_interface_filetypes),
      modes_denylist = { "i" },
      modes_allowlist = { "n", "c", "r", "R", "s", "S", "v", "V", "\22" },
      max_file_lines = 400,
    })
  end,
}
