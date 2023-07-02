return {
  "echasnovski/mini.move",
  keys = {
    { "<M-Left>", mode = { "n", "v" } },
    { "<M-Down>", mode = { "n", "v" } },
    { "<M-Up>", mode = { "n", "v" } },
    { "<M-Right>", mode = { "n", "v" } },
  },
  config = function()
    require("mini.move").setup({
      mappings = {
        left = "<M-Left>",
        line_left = "<M-Left>",
        right = "<M-Right>",
        line_right = "<M-Right>",
        down = "<M-Down>",
        line_down = "<M-Down>",
        up = "<M-Up>",
        line_up = "<M-Up>",
      },
    })
  end,
}
