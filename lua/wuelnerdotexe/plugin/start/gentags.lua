return {
  "JMarkin/gentags.lua",
  dependencies = "nvim-lua/plenary.nvim",
  cond = vim.api.nvim_call_function("executable", { "ctags" }) == 1,
  cmd = { "GenCTags", "GenTagsEnable", "GenTagsDisable" },
  event = "FileType",
  config = function() require("gentags").setup() end,
}
