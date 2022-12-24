local config = function()
  require("Comment").setup({
    toggler = { line = "gcc", block = "<Nop>" },
    opleader = { line = "gc", block = "<Nop>" },
    mappings = { basic = true, extra = true },
    pre_hook = function(ctx)
      local bo_filetype = vim.bo.filetype

      if bo_filetype == "javascriptreact" or bo_filetype == "typescriptreact" then
        local ctx_ctype = ctx.ctype
        local type = ctx_ctype == require("Comment.utils").ctype.linewise and "__default" or "__multiline"
        local location = nil
        local ctx_cmotion = ctx.cmotion

        if ctx_ctype == require("Comment.utils").ctype.blockwise then
          location = require("ts_context_commentstring.utils").get_cursor_location()
        elseif
          ctx_cmotion == require("Comment.utils").cmotion.v or ctx_cmotion == require("Comment.utils").cmotion.V
        then
          location = require("ts_context_commentstring.utils").get_visual_start_location()
        end

        return require("ts_context_commentstring.internal").calculate_commentstring({ key = type, location = location })
      end
    end,
    post_hook = nil,
  })
end

return config
