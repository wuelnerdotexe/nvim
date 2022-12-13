local M = {}

M.config = function()
  vim.opt.shortmess:append("I")
  vim.opt.cmdheight = 0
  vim.opt.showcmd = false
  vim.opt.showmode = false

  local hover_opts = { border = { style = "rounded" }, position = { row = 2 } }

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
        Property = "",
        Snippet = "",
        Struct = "",
        Text = "",
        Unit = "",
        Value = "",
        Variable = "",
      },
    },
    lsp = {
      progress = { enabled = false, throttle = 40 },
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
      hover = { view = "hover", opts = hover_opts },
      signature = {
        view = "hover",
        auto_open = { throttle = 40 },
        opts = hover_opts,
      },
    },
    presets = {
      command_palette = true,
      long_message_to_split = true,
      lsp_doc_border = true,
    },
    throttle = 40,
    views = {
      split = { size = "25%" },
      win_options = { wrap = false },
      hover = hover_opts,
    },
  })

  require("notify").setup({
    background_colour = "NormalFloat",
    fps = 24,
    render = "minimal",
    timeout = 300,
  })

  vim.api.nvim_create_autocmd("FileType", {
    pattern = "noice",
    command = "setlocal signcolumn=no nonumber norelativenumber nolist",
  })
end

return M
