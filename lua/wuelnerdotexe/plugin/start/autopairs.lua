return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  config = function()
    require("nvim-autopairs").setup({
      disable_filetype = require("wuelnerdotexe.utils").interface.filetypes,
      enable_check_bracket_line = false,
      check_ts = true,
      map_cr = false,
      fast_wrap = { highlight = "Question", highlight_grey = "Dimmed" },
    })
  end,
}
