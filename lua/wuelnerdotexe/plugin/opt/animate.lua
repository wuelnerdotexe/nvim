return {
  "echasnovski/mini.animate",
  event = "UIEnter",
  init = function() require("wuelnerdotexe.plugin.util").add_colorscheme_integration("animate") end,
  config = function()
    require("mini.animate").setup({
      open = { enable = not require("lazy.core.config").spec.plugins["nvim-spectre"] },
      cursor = { timing = function(_, n) return 125 / n end },
      scroll = { timing = function(_, n) return 67 / n end },
      resize = { timing = function(_, n) return 67 / n end },
      close = { timing = function(_, n) return 67 / n end },
    })
  end,
}
