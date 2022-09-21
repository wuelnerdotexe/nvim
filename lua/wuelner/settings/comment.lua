local M = {}

M.config = function()
  require('Comment').setup({
    toggler = { line = 'gcc', block = 'gcb' },
    opleader = nil,
    mappings = { basic = true, extra = false },
    pre_hook = function(ctx)
      if vim.bo.filetype == 'typescriptreact' then
        local U = require('Comment.utils')
        local commentstring_utils = require('ts_context_commentstring.utils')
        local type = ctx.ctype == U.ctype.linewise and '__default' or '__multiline'
        local location = nil

        if ctx.ctype == U.ctype.blockwise then
          location = commentstring_utils.get_cursor_location()
        elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
          location = commentstring_utils.get_visual_start_location()
        end

        return require('ts_context_commentstring.internal').calculate_commentstring({
          key = type,
          location = location
        })
      end
    end,
    post_hook = nil
  })
end

return M

