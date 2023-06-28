local M = {}

M.colorscheme_integrations = {}

M.add_colorscheme_integration = function(plugin)
  table.insert(M.colorscheme_integrations, plugin)

  vim.api.nvim_set_var("enfocado_plugins", M.colorscheme_integrations)
end

local arguments

M.enter_with_arguments = function()
  if arguments ~= nil then return arguments end

  arguments = vim.api.nvim_call_function("argc", {}) == 1 and true or false

  return arguments
end

M.plugin_options = {}

M.set_option = function(option, value)
  M.plugin_options[option] = vim.api.nvim_get_option_value(option, { scope = "global" })

  if M.plugin_options[option] == value then return end

  vim.api.nvim_set_option_value(option, value, {})

  M.plugin_options[option] = value
end

local sidebar_width

M.get_sidebar_width = function()
  if sidebar_width ~= nil then return sidebar_width end

  local columns = vim.api.nvim_get_option_value("columns", { scope = "global" })
  sidebar_width = math.floor((columns / (columns >= 160 and 3 or 2)) / 2)

  return sidebar_width
end

M.user_interface_filetypes = { "checkhealth", "help", "man", "qf" }

return M
