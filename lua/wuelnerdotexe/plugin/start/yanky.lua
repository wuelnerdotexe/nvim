local M = {
  "gbprod/yanky.nvim",
  enabled = not os.getenv("WAYLAND_DISPLAY"),
  keys = {
    { "y", "<Plug>(YankyYank)", mode = { "n", "x" } },
    { "p", function() require("yanky").put("p", false) end },
    { "p", function() require("yanky").put("p", true) end, mode = "x" },
    { "P", function() require("yanky").put("P", false) end },
    { "P", function() require("yanky").put("P", true) end, mode = "x" },
    { "]p", function() require("yanky").cycle(1) end },
    { "[p", function() require("yanky").cycle(-1) end },
  },
  cmd = { "YankyClearHistory", "YankyRingHistory" },
  lazy = true,
  init = function() require("wuelnerdotexe.plugin.util").add_colorscheme_integration("yanky") end,
  opts = { picker = { telescope = { use_default_mappings = false } }, highlight = { timer = 125 } },
  config = function(_, opts) require("yanky").setup(opts) end,
}

if vim.uv.os_uname().sysname ~= "Windows_NT" then
  M.dependencies = "kkharji/sqlite.lua"
  M.opts.ring =
    { storage = "sqlite", storage_path = vim.api.nvim_call_function("stdpath", { "data" }) .. "/databases/yanky.db" }
end

return M
