return {
  "tpope/vim-sleuth",
  event = require("wuelnerdotexe.utils").plugins.open_file_event,
  init = function()
    for _, filetype in ipairs(require("wuelnerdotexe.utils").interface.filetypes) do
      vim.api.nvim_set_var("sleuth_" .. filetype .. "_heuristics", 0)
    end
  end,
}
