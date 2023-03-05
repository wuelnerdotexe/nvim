return {
  "echasnovski/mini.move",
  keys = {
    { "<A-Left>", mode = { "n", "v" } },
    { "<A-Down>", mode = { "n", "v" } },
    { "<A-Up>", mode = { "n", "v" } },
    { "<A-Right>", mode = { "n", "v" } },
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
