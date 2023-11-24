return {
  "akinsho/bufferline.nvim",
  event = "UIEnter",
  init = function()
    require("wuelnerdotexe.plugin.util").add_colorscheme_integration("bufferline")

    require("wuelnerdotexe.plugin.util").set_option("showtabline", 0)
    require("wuelnerdotexe.plugin.util").set_option("termguicolors", true)

    if not os.getenv("TMUX") then require("wuelnerdotexe.plugin.util").set_option("mousemoveevent", true) end

    vim.opt.listchars:append({ precedes = "…", extends = "…" })
  end,
  opts = function(_, opts)
    opts.options = opts.options or {}

    opts.options.max_name_length = 16

    opts.options.max_prefix_length = 16

    opts.options.tab_size = 20

    opts.options.indicator = { icon = "▎", style = "icon" }

    opts.options.show_close_icon = false

    opts.options.separator_style = { "▎", "▎" }

    opts.options.hover = {
      enabled = not os.getenv("TMUX"),
      delay = vim.api.nvim_get_option_value("updatetime", { scope = "global" }),
      reveal = { "close" },
    }
  end,
  config = function(_, opts)
    require("bufferline").setup(opts)

    vim.api.nvim_set_keymap("", "<S-End>", "", { callback = function() require("bufferline").move(1) end })
    vim.api.nvim_set_keymap("", "<S-Home>", "", { callback = function() require("bufferline").move(-1) end })
    vim.api.nvim_set_keymap("n", "gb", "", { callback = function() require("bufferline").cycle(1) end })
    vim.api.nvim_set_keymap("", "<S-PageDown>", "", { callback = function() require("bufferline").cycle(1) end })
    vim.api.nvim_set_keymap("n", "gB", "", { callback = function() require("bufferline").cycle(-1) end })
    vim.api.nvim_set_keymap("", "<S-PageUp>", "", { callback = function() require("bufferline").cycle(-1) end })
  end,
}
