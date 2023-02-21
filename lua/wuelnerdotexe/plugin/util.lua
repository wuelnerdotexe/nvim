local M = {}
local border
local sidebar_width

M.empty_table = {}

M.get_sidebar_width = function()
  if sidebar_width then
    return sidebar_width
  else
    local columns = vim.api.nvim_get_option_value("columns", M.empty_table)
    sidebar_width = math.floor((columns / (columns >= 160 and 3 or 2)) / 2)

    return sidebar_width
  end
end

M.get_border = function()
  if border then
    return border
  else
    if not require("wuelnerdotexe.plugin.config").border then
      border = { enabled = false, style = "none", chars = { " ", " ", " ", " ", " ", " ", " ", " " } }

      return border
    end

    border = { enabled = true, style = "rounded", chars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" } }

    return border
  end
end

return M
