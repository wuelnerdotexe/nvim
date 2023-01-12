local config = function()
  require('dressing').setup({
    input = { insert_only = false, win_options = { wrap = true } },
    select = { backend = { "nui", "builtin" } },
  })
end

return config
