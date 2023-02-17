local lazypath = vim.api.nvim_call_function("stdpath", { "data" }) .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.api.nvim_call_function("system", {
    { "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", lazypath },
  })
end

local rtp = vim.api.nvim_get_option_value("rtp", {})

vim.api.nvim_set_option_value("rtp", rtp == "" and lazypath or lazypath .. "," .. rtp, {})

vim.api.nvim_set_var("loaded_python3_provider", 0)
vim.api.nvim_set_var("loaded_node_provider", 0)
vim.api.nvim_set_var("loaded_ruby_provider", 0)
vim.api.nvim_set_var("loaded_perl_provider", 0)

require("lazy").setup({
  spec = { { import = "wuelnerdotexe.plugin.start" }, { import = "wuelnerdotexe.plugin.opt" } },
  defaults = { lazy = true, version = false },
  dev = { path = "~/Workspace", patterns = { "wuelnerdotexe" }, fallback = true },
  install = { colorscheme = { "enfocado" } },
  ui = {
    border = require("wuelnerdotexe.utils").interface.border.style,
    browser = "chrome",
    throttle = 42,
    custom_keys = { ["<localleader>l"] = false },
  },
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
