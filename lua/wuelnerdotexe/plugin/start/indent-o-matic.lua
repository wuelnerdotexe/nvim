return {
  "Darazaki/indent-o-matic",
  event = require("wuelnerdotexe.plugin.config").open_file_event,
  config = function()
    local disable_filetypes = {}
    local max_lines = { max_lines = 0 }

    for _, filetype in ipairs(require("wuelnerdotexe.plugin.config").uifiletypes) do
      disable_filetypes["filetype_" .. filetype] = max_lines
    end

    require("indent-o-matic").setup(disable_filetypes)
  end,
}
