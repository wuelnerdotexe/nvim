return {
  "gbprod/yanky.nvim",
  enabled = not require("wuelnerdotexe.plugin.config").minimal_setup,
  keys = {
    { "y", "<Plug>(YankyYank)", mode = { "n", "x" } },
    {
      "p",
      function()
        if vim.env.TMUX then
          local ok, tmux_copy = pcall(require, "tmux.copy")

          if ok then tmux_copy.sync_registers() end
        end

        require("yanky").put("p", false)
      end,
    },
    {
      "P",
      function()
        if vim.env.TMUX then
          local ok, tmux_copy = pcall(require, "tmux.copy")

          if ok then tmux_copy.sync_registers() end
        end

        require("yanky").put("P", false)
      end,
    },
    {
      "gp",
      function()
        if vim.env.TMUX then
          local ok, tmux_copy = pcall(require, "tmux.copy")

          if ok then tmux_copy.sync_registers() end
        end

        require("yanky").put("gp", false)
      end,
    },
    {
      "gP",
      function()
        if vim.env.TMUX then
          local ok, tmux_copy = pcall(require, "tmux.copy")

          if ok then tmux_copy.sync_registers() end
        end

        require("yanky").put("gP", false)
      end,
    },
    {
      "p",
      function()
        if vim.env.TMUX then
          local ok, tmux_copy = pcall(require, "tmux.copy")

          if ok then tmux_copy.sync_registers() end
        end

        require("yanky").put("p", true)
      end,
      mode = "x",
    },
    {
      "P",
      function()
        if vim.env.TMUX then
          local ok, tmux_copy = pcall(require, "tmux.copy")

          if ok then tmux_copy.sync_registers() end
        end

        require("yanky").put("P", true)
      end,
      mode = "x",
    },
    {
      "gp",
      function()
        if vim.env.TMUX then
          local ok, tmux_copy = pcall(require, "tmux.copy")

          if ok then tmux_copy.sync_registers() end
        end

        require("yanky").put("gp", true)
      end,
      mode = "x",
    },
    {
      "gP",
      function()
        if vim.env.TMUX then
          local ok, tmux_copy = pcall(require, "tmux.copy")

          if ok then tmux_copy.sync_registers() end
        end

        require("yanky").put("gP", true)
      end,
      mode = "x",
    },
    { "<C-Left>", "<Plug>(YankyCycleBackward)" },
    { "<C-Right>", "<Plug>(YankyCycleForward)" },
  },
  config = function() require("yanky").setup({ highlight = { timer = 125 } }) end,
}
