return {
  "Darazaki/indent-o-matic",
  event = require("wuelnerdotexe.plugin.config").open_file_event,
  dependencies = "nvim-treesitter/nvim-treesitter",
  config = function()
    local disable_filetypes = {}
    local max_lines = { max_lines = 0 }

    for _, uifiletype in pairs(require("wuelnerdotexe.plugin.config").uifiletypes) do
      disable_filetypes["filetype_" .. uifiletype] = max_lines
    end

    require("indent-o-matic").setup(disable_filetypes)
  end,
}
