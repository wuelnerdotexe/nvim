return {
  {
    "lukas-reineke/indent-blankline.nvim",
    cmd = {
      "IndentBlanklineDisable",
      "IndentBlanklineEnable",
      "IndentBlanklineRefresh",
      "IndentBlanklineRefreshScroll",
      "IndentBlanklineToggle",
    },
    event = "FileType",
    init = function() require("wuelnerdotexe.plugin.util").add_colorscheme_integration("indent-blankline") end,
    config = function()
      require("indent_blankline").setup({
        use_treesitter = true,
        show_current_context = require("lazy.core.config").spec.plugins["mini.indentscope"] == nil,
        show_current_context_start = true,
        show_trailing_blankline_indent = false,
        char = "▏",
        context_char = "▏",
        buftype_exclude = { "help", "loclist", "nofile", "prompt", "quickfix", "terminal" },
        filetype_exclude = { "list", "netrw", "" },
      })
    end,
  },
  {
    "echasnovski/mini.indentscope",
    keys = {
      { "ii", mode = { "x", "o" } },
      { "ai", mode = { "x", "o" } },
      { "]i", mode = { "n", "x", "o" } },
      { "[i", mode = { "n", "x", "o" } },
    },
    event = "FileType",
    init = function()
      require("wuelnerdotexe.plugin.util").add_colorscheme_integration("indentscope")

      vim.api.nvim_create_autocmd({ "VimEnter", "BufEnter" }, {
        callback = function(ev)
          if vim.api.nvim_get_option_value("filetype", { buf = ev.buf }) ~= "" then return end

          vim.api.nvim_buf_set_var(ev.buf, "miniindentscope_disable", true)
        end,
      })
    end,
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = vim.list_extend({ "list", "netrw" }, require("wuelnerdotexe.plugin.util").user_interface_filetypes),
        callback = function(ev) vim.api.nvim_buf_set_var(ev.buf, "miniindentscope_disable", true) end,
      })

      require("mini.indentscope").setup({
        draw = { delay = vim.api.nvim_get_option_value("updatetime", { scope = "global" }) },
        symbol = "▏",
      })
    end,
  },
}
