return {
  "cshuaimin/ssr.nvim",
  dependencies = "nvim-treesitter/nvim-treesitter",
  keys = {
    {
      "<leader>sr",
      function() require("ssr").open() end,
      desc = "General: [s]tructural search and [r]eplace in the current directory",
      mode = { "n", "x" },
    },
  },
  config = function() require("ssr").setup({ border = "rounded", keymaps = { replace_all = "<localleader>rr" } }) end,
}
