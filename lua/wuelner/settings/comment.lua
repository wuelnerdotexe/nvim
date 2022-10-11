local M = {}

M.config = function()
  require('Comment').setup({
    toggler = { line = 'gcc', block = '<Nop>' },
    opleader = { line = 'gc', block = '<Nop>' },
    mappings = { basic = true, extra = true },
    pre_hook = function(ctx)
      local bo_filetype = vim.bo.filetype

      if bo_filetype == 'javascriptreact' or bo_filetype == 'typescriptreact'
      then
        local U = require('Comment.utils')
        local commentstring_utils = require('ts_context_commentstring.utils')
        local ctx_ctype = ctx.ctype
        local u_ctype = U.ctype
        local type = ctx_ctype == u_ctype.linewise and '__default' or '__multiline'
        local location = nil
        local ctx_cmotion = ctx.cmotion
        local u_cmotion = U.cmotion

        if ctx_ctype == u_ctype.blockwise
        then
          location = commentstring_utils.get_cursor_location()
        elseif ctx_cmotion == u_cmotion.v or ctx_cmotion == u_cmotion.V
        then
          location = commentstring_utils.get_visual_start_location()
        end

        return require(
          'ts_context_commentstring.internal'
        ).calculate_commentstring({ key = type, location = location })
      end
    end,
    post_hook = nil
  })
end

return M

