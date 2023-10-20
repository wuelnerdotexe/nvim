return {
  "sontungexpt/url-open",
  event = { "BufEnter", "WinEnter" },
  config = function()
    require("url-open").setup({
      open_only_when_cursor_on_url = true,
      highlight_url = {
        all_urls = { enabled = true, fg = require("wuelnerdotexe.plugin.util").get_scheme_color("FileLink", "fg") },
        cursor_move = { fg = require("wuelnerdotexe.plugin.util").get_scheme_color("Directory", "fg") },
      },
    })

    vim.api.nvim_set_keymap("n", "gx", "", { callback = function() vim.api.nvim_command("URLOpenUnderCursor") end })
  end,
}
