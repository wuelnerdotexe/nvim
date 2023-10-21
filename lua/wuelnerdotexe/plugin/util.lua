local M = {}

M.plugin_options = {}

M.set_option = function(option, value)
  M.plugin_options[option] = vim.api.nvim_get_option_value(option, { scope = "global" })

  if M.plugin_options[option] == value then return end

  vim.api.nvim_set_option_value(option, value, {})

  M.plugin_options[option] = value
end

local arguments

M.enter_with_arguments = function()
  if arguments ~= nil then return arguments end

  arguments = vim.api.nvim_call_function("argc", { -1 }) == 1 and true or false

  return arguments
end

local colorscheme_integrations = {}

M.add_colorscheme_integration = function(plugin)
  table.insert(colorscheme_integrations, plugin)

  vim.api.nvim_set_var("enfocado_plugins", colorscheme_integrations)
end

local sidebar_width

M.get_sidebar_width = function()
  if sidebar_width ~= nil then return sidebar_width end

  local columns = vim.api.nvim_get_option_value("columns", { scope = "global" })
  sidebar_width = math.floor((columns / (columns >= 160 and 3 or 2)) / 2)

  return sidebar_width
end

local scheme_colors_loaded = {}

M.get_scheme_color = function(name, attr)
  local hl = vim.api.nvim_get_hl(0, { name = name, link = false })[attr]

  if hl == nil then return "NONE" end

  if scheme_colors_loaded[hl] then return scheme_colors_loaded[hl] end

  if type(hl) == "string" or string.match(attr, "cterm") then
    scheme_colors_loaded[hl] = hl

    return scheme_colors_loaded[hl]
  end

  scheme_colors_loaded[hl] = string.format("#%06x", hl)

  return scheme_colors_loaded[hl]
end

M.user_interface_filetypes = { "checkhealth", "help", "lazy", "man", "netrw", "qf" }

return M
