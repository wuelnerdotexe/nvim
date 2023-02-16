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
        priority = 11,
        threshold = 1,
        disable_float_win = true,
        disabled_filetypes = {
          "aerial",
          "checkhealth",
          "dap-repl",
          "dapui_breakpoints",
          "dapui_console",
          "dapui_hover",
          "dapui_scopes",
          "dapui_stacks",
          "dapui_watches",
          "DressingInput",
          "DressingSelect",
          "fern",
          "lazy",
          "lspinfo",
          "mason",
          "nerdterm",
          "noice",
          "null-ls-info",
          "qf",
          "TelescopePrompt",
        },
      })
    end,
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
  {
    "tamton-aquib/flirt.nvim",
    event = "VeryLazy",
    config = function()
      require("flirt").setup({
        default_move_mappings = false,
        default_resize_mappings = false,
        default_mouse_mappings = false,
      })
    end,
  },
}
