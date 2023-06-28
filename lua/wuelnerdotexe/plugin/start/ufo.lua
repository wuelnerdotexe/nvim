return {
  "kevinhwang91/nvim-ufo",
  dependencies = "kevinhwang91/promise-async",
  keys = {
    { "zR", function() require("ufo").openAllFolds() end },
    { "zM", function() require("ufo").closeAllFolds() end },
    { "zr", function() require("ufo").openFoldsExceptKinds() end },
    { "zm", function() require("ufo").closeFoldsWith() end },
    { "zp", function() require("ufo").peekFoldedLinesUnderCursor() end },
  },
  cmd = { "UfoEnable", "UfoDisable", "UfoInspect", "UfoAttach", "UfoDetach", "UfoEnableFold", "UfoDisableFold" },
  event = "BufEnter",
  init = function()
    require("wuelnerdotexe.plugin.util").add_colorscheme_integration("ufo")

    require("wuelnerdotexe.plugin.util").set_option("foldenable", true)
    require("wuelnerdotexe.plugin.util").set_option("foldlevel", 99)
    require("wuelnerdotexe.plugin.util").set_option("foldlevelstart", 99)
    require("wuelnerdotexe.plugin.util").set_option("foldcolumn", "0")

    vim.opt.fillchars:append({ foldopen = "", foldclose = "" })
  end,
  config = function()
    require("ufo").setup({
      open_fold_hl_timeout = 125,
      provider_selector = function(_, filetype, buftype)
        if
          filetype == ""
          or filetype == "netrw"
          or vim.tbl_contains({ "help", "loclist", "nofile", "prompt", "quickfix", "terminal" }, buftype)
        then
          return ""
        end

        return { "lsp", "indent" }
      end,
      preview = {
        win_config = {
          border = "rounded",
          winblend = vim.api.nvim_get_option_value("winblend", { scope = "global" }),
          winhighlight = "Normal:NormalFloat",
        },
        mappings = {
          scrollB = "<C-b>",
          scrollF = "<C-f>",
          scrollU = "<C-u>",
          scrollD = "<C-d>",
          scrollE = "<C-e>",
          scrollY = "<C-y>",
          jumpTop = "gg",
          jumpBot = "G",
          close = "q",
          switch = "<Tab>",
          trace = "<CR>",
        },
      },
    })
  end,
}
