local M = {}

M.config = function()
  vim.opt.shortmess:append("I")
  vim.opt.cmdheight = 0

  require("noice").setup({
    popupmenu = {
      kind_icons = {
        Class = "",
        Color = "",
        Constant = "",
        Constructor = "",
        Enum = "",
        EnumMember = "",
        Field = "",
        File = "",
        Folder = "",
        Function = "",
        Interface = "",
        Keyword = "",
        Method = "",
        Module = "",
        Operator = "",
        Property = "",
        Reference = "",
        Snippet = "",
        Struct = "",
        Text = "",
        Unit = "",
        Value = "",
        Variable = "",
      },
    },
    lsp = {
      progress = { throttle = 40 },
      hover = { enabled = false },
      signature = { auto_open = { throttle = 40 } },
    },
    presets = {
      command_palette = true,
      long_message_to_split = true,
      lsp_doc_border = true,
    },
    throttle = 40,
  })

  require("notify").setup({
    background_colour = "FloatShadow",
    fps = 24,
    render = "minimal",
    timeout = 300
  })

  vim.api.nvim_create_autocmd("FileType", {
    pattern = "noice",
    callback = function()
      vim.opt.list = false
      vim.opt.relativenumber = false
    end,
  })
end

return M
