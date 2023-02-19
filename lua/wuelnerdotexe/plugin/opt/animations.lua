return {
  {
    "gen740/SmoothCursor.nvim",
    event = "VeryLazy",
    config = function()
      require("smoothcursor").setup({
        cursor = nil,
        texthl = nil,
        fancy = {
          enable = true,
          head = { cursor = nil, texthl = nil, linehl = nil },
          tail = { cursor = nil, texthl = nil, linehl = nil },
        },
        speed = 42,
        intervals = 67,
        priority = require("wuelnerdotexe.plugin.configs").signs_priority.smoothcursor,
        threshold = 1,
        disable_float_win = true,
        disabled_filetypes = require("wuelnerdotexe.plugin.configs").uifiletypes,
      })
    end,
  },
  {
    "tamton-aquib/duck.nvim",
    keys = {
      { "<leader>dh", function() require("duck").hatch() end },
      { "<leader>dc", function() require("duck").cook() end },
    },
  },
  {
    "echasnovski/mini.animate",
    event = "VeryLazy",
    config = function()
      local timing_linear = require("mini.animate").gen_timing.linear({ duration = 67, unit = "total" })
      local config_timing = { timing = timing_linear }

      require("mini.animate").setup({
        cursor = config_timing,
        scroll = config_timing,
        resize = config_timing,
        open = config_timing,
        close = config_timing,
      })
    end,
  },
}
