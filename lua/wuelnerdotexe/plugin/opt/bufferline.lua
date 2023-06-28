return {
  "akinsho/bufferline.nvim",
  event = "UIEnter",
  init = function()
    require("wuelnerdotexe.plugin.util").add_colorscheme_integration("bufferline")

    require("wuelnerdotexe.plugin.util").set_option("termguicolors", true)

    vim.opt.listchars:append({ precedes = "…", extends = "…" })
  end,
  config = function()
    require("bufferline").setup({
      options = {
        max_name_length = 16,
        max_prefix_length = 16,
        tab_size = 20,
        indicator = { icon = "▎", style = "icon" },
        offsets = { { filetype = "neo-tree", text = "SIDEBAR", highlight = "Ignore", separator = false } },
        show_close_icon = false,
        separator_style = { "▎", "▎" },
      },
    })

    vim.api.nvim_set_keymap("", "<S-End>", "", { callback = function() require("bufferline").move(1) end })
    vim.api.nvim_set_keymap("", "<S-Home>", "", { callback = function() require("bufferline").move(-1) end })
    vim.api.nvim_set_keymap("n", "gb", "", { callback = function() require("bufferline").cycle(1) end })
    vim.api.nvim_set_keymap("", "<S-PageDown>", "", { callback = function() require("bufferline").cycle(1) end })
    vim.api.nvim_set_keymap("n", "gB", "", { callback = function() require("bufferline").cycle(-1) end })
    vim.api.nvim_set_keymap("", "<S-PageUp>", "", { callback = function() require("bufferline").cycle(-1) end })
  end,
}
