local mode = { "i", "c" }

return {
  "altermo/npairs-integrate-upair",
  lazy = true,
  keys = {
    { "{", mode = mode },
    { "[", mode = mode },
    { "(", mode = mode },
    { '"', mode = mode },
    { "'", mode = mode },
    { "`", mode = mode },
    { "<CR>", mode = "i" },
    { "<BS>", mode = "i" },
    { "<A-e>", mode = "i" },
    { "<A-E>", mode = "i" },
    { "<A-]>", mode = "i" },
    { "<A-C-e>", mode = "i" },
    { "<Space>", mode = "i" },
  },
  dependencies = {
    { "windwp/nvim-autopairs", dependencies = "nvim-treesitter/nvim-treesitter" },
    { "altermo/ultimate-autopair.nvim", dependencies = "nvim-treesitter/nvim-treesitter" },
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "IntPairsComp",
      callback = function()
        if not package.loaded["npairs-int-upair"] then
          require("lazy").load({ plugins = { "npairs-integrate-upair" } })
        end

        require("cmp").event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())
      end,
      once = true,
    })
  end,
  config = function()
    require("npairs-int-upair").setup({
      bs = "u",
      npairs_conf = {
        disable_filetype = {
          "aerial",
          "checkhealth",
          "dapui_breakpoints",
          "dapui_console",
          "dapui_scopes",
          "dapui_stacks",
          "DressingSelect",
          "help",
          "lazy",
          "lspinfo",
          "man",
          "mason",
          "netrw",
          "null-ls-info",
          "qf",
        },
        check_ts = true,
        fast_wrap = { highlight = "Question", highlight_grey = "Dimmed" },
      },
      upair_conf = {
        extensions = {
          filetype = {
            nft = {
              "aerial",
              "checkhealth",
              "dapui_breakpoints",
              "dapui_console",
              "dapui_scopes",
              "dapui_stacks",
              "DressingSelect",
              "help",
              "lazy",
              "lspinfo",
              "man",
              "mason",
              "netrw",
              "null-ls-info",
              "qf",
            },
          },
        },
      },
    })
  end,
}
