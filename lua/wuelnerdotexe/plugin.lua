TBL = require("wuelnerdotexe.plugin.util").empty_table

local lazypath = vim.api.nvim_call_function("stdpath", { "data" }) .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.api.nvim_call_function("system", {
    { "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", lazypath },
  })
end

local rtp = vim.api.nvim_get_option_value("rtp", TBL)

vim.api.nvim_set_option_value("rtp", rtp == "" and lazypath or lazypath .. "," .. rtp, TBL)

local imports = { { import = "wuelnerdotexe.plugin.start" } }

if not require("wuelnerdotexe.plugin.config").minimal_setup then
  table.insert(imports, { import = "wuelnerdotexe.plugin.opt" })
end

require("lazy").setup({
  spec = imports,
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
