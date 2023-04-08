TBL = require("wuelnerdotexe.plugin.util").empty_table

local rtp = vim.api.nvim_get_option_value("rtp", TBL)
local lazy = vim.api.nvim_call_function("stdpath", { "data" }) .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazy) then
  vim.api.nvim_call_function("system", {
    { "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", lazy },
  })
end

vim.api.nvim_set_option_value("rtp", rtp == "" and lazy or lazy .. "," .. rtp, TBL)

require("lazy").setup({
  spec = { { import = "wuelnerdotexe.plugin.start" }, { import = "wuelnerdotexe.plugin.opt" } },
  defaults = { lazy = true, version = false },
  dev = { path = "~/Workspace", patterns = { "wuelnerdotexe" }, fallback = true },
  install = { colorscheme = { "enfocado" } },
  ui = { border = require("wuelnerdotexe.plugin.util").get_border().style, browser = "chrome", throttle = 42 },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "nvim",
        "man",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "rplugin",
        "spellfile",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
