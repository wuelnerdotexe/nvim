return {
  "Darazaki/indent-o-matic",
  cmd = "IndentOMatic",
  event = { "BufAdd", "BufReadPost", "BufNewFile" },
  config = function()
    local max_lines = { max_lines = 0 }
    local disable_filetypes = { filetype_ = max_lines, filetype_list = max_lines }

    for _, uifiletype in pairs(require("wuelnerdotexe.plugin.config").uifiletypes) do
      disable_filetypes["filetype_" .. uifiletype] = max_lines
    end

    require("indent-o-matic").setup(disable_filetypes)
  end,
}
