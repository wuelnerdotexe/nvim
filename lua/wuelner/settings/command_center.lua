local M = {}

M.config = function()
  local command_center = require("command_center")

  command_center.add({
    {
      desc = "Toggle file tree",
      cmd = "<Cmd>Fern . -drawer -toggle<CR>",
      keys = { "n", "<leader>ff" },
      category = "GENERAL",
    },
    {
      desc = "Reveal current file in file tree",
      cmd = "<Cmd>Fern . -reveal=% -drawer -toggle<CR>",
      keys = { "n", "<leader>fr" },
      category = "GENERAL",
    },
    {
      desc = "Find files in the current directory",
      cmd = "<Cmd>Telescope find_files<CR>",
      keys = { "n", "<leader>ff" },
      category = "GENERAL",
    },
    {
      desc = "Find recently opened files",
      cmd = "<Cmd>Telescope oldfiles<CR>",
      keys = { "n", "<leader>of" },
      category = "GENERAL",
    },
    {
      desc = "Find Vim file marks",
      cmd = "<Cmd>Telescope marks<CR>",
      keys = { "n", "<leader>mf" },
      category = "GENERAL",
    },
    {
      desc = "Find words in the current directory",
      cmd = "<Cmd>Telescope live_grep<CR>",
      keys = { "n", "<leader>wf" },
      category = "GENERAL",
    },
    {
      desc = "Find Vim help tags",
      cmd = "<Cmd>Telescope help_tags<CR>",
      keys = { "n", "<leader>hf" },
      category = "GENERAL",
    },
    {
      desc = "Toggle document symbols",
      cmd = "<Cmd>AerialToggle!<CR>",
      keys = { "n", "<leader>st" },
      category = "GENERAL",
    },
    {
      desc = "Open the terminal in a new tab",
      cmd = "<Cmd>tabnew +terminal<CR>",
      keys = { "n", "<leader>to" },
      category = "GENERAL",
    },
    {
      desc = "Toggle bottom terminal",
      cmd = function()
        require("wuelner.utils").bufresize_toggle("NERDTermToggle", "nerdterm")
      end,
      keys = { "n", "<leader>tt" },
      category = "GENERAL",
    },
  }, { mode = command_center.mode.ADD })

  vim.keymap.set("n", "<C-Bslash>", "<CMD>Telescope command_center<CR>", {
    silent = true,
  })
end

return M
