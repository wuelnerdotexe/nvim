return {
  "Darazaki/indent-o-matic",
  cmd = "IndentOMatic",
  event = { "BufAdd", "BufReadPost", "BufNewFile" },
  config = function()
    local max_lines = { max_lines = 0 }
    local disable_filetypes = { filetype_ = max_lines, filetype_list = max_lines }

    for _, ui_ft in pairs(require("wuelnerdotexe.plugin.util").user_interface_filetypes) do
      disable_filetypes["filetype_" .. ui_ft] = max_lines
    end

    require("indent-o-matic").setup(vim.tbl_deep_extend("error", {}, disable_filetypes))
  end,
}
