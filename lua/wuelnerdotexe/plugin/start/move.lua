local mode = { "n", "v" }

return {
  "echasnovski/mini.move",
  keys = {
    { "<M-Left>", mode = mode },
    { "<M-Down>", mode = mode },
    { "<M-Up>", mode = mode },
    { "<M-Right>", mode = mode },
  },
  config = function()
    require("mini.move").setup({
      mappings = {
        left = "<M-Left>",
        line_left = "<M-Left>",
        right = "<M-Right>",
        line_right = "<M-Right>",
        down = "<M-DOwn>",
        line_down = "<M-Down>",
        up = "<M-Up>",
        line_up = "<M-Up>",
      },
    })
  end,
}
