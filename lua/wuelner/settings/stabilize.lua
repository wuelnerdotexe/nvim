local M = {}

M.config = function()
  require('stabilize').setup({ ignore = { buftype = nil, filetype = nil } })
end

return M

