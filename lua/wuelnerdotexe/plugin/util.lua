local args
local sidebar_width

local M = { empty_table = {}, plugin_options = {} }

M.set_option = function(option, value)
  M.plugin_options[option] = vim.api.nvim_get_option_value(option, M.empty_table)

  if M.plugin_options[option] == value then return end

  vim.api.nvim_set_option_value(option, value, M.empty_table)

  M.plugin_options[option] = value
end

M.enter_with_args = function()
  if args ~= nil then return args end

  args = vim.api.nvim_call_function("argc", M.empty_table) == 1 and true or false

  return args
end

M.get_sidebar_width = function()
  if sidebar_width ~= nil then return sidebar_width end

  local columns = vim.api.nvim_get_option_value("columns", M.empty_table)
  sidebar_width = math.floor((columns / (columns >= 160 and 3 or 2)) / 2)

  return sidebar_width
end

return M
