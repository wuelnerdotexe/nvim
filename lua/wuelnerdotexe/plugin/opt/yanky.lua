return {
  "gbprod/yanky.nvim",
  enabled = not require("wuelnerdotexe.plugin.config").minimal_setup,
  keys = {
    { "y", "<Plug>(YankyYank)", mode = { "n", "x" } },
    {
      "p",
      function()
        if os.getenv("TMUX") and package.loaded["tmux"] then require("tmux.copy").sync_registers() end

        require("yanky").put("p", false)
      end,
    },
    {
      "P",
      function()
        if os.getenv("TMUX") and package.loaded["tmux"] then require("tmux.copy").sync_registers() end

        require("yanky").put("P", false)
      end,
    },
    {
      "p",
      function()
        if os.getenv("TMUX") and package.loaded["tmux"] then require("tmux.copy").sync_registers() end

        require("yanky").put("p", true)
      end,
      mode = "x",
    },
    {
      "P",
      function()
        if os.getenv("TMUX") and package.loaded["tmux"] then require("tmux.copy").sync_registers() end

        require("yanky").put("P", true)
      end,
      mode = "x",
    },
    { "<C-Left>", "<Plug>(YankyCycleBackward)" },
    { "<C-Right>", "<Plug>(YankyCycleForward)" },
  },
  init = function() require("wuelnerdotexe.plugin.util").set_option("clipboard", "unnamedplus") end,
  config = function() require("yanky").setup({ highlight = { timer = 125 } }) end,
}
