return {
  "tpope/vim-sleuth",
  event = require("wuelnerdotexe.plugin.configs").open_file_event,
  init = function()
    for _, filetype in ipairs(require("wuelnerdotexe.plugin.configs").uifiletypes) do
      vim.api.nvim_set_var("sleuth_" .. filetype .. "_heuristics", 0)
    end
  end,
}
