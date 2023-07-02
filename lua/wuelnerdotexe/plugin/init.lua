local lazypath = vim.api.nvim_call_function("stdpath", { "data" }) .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.api.nvim_call_function("system", {
    { "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", lazypath },
  })
end

vim.opt.runtimepath:prepend(os.getenv("LAZY") or lazypath)

require("wuelnerdotexe.plugin.util").add_colorscheme_integration("lazy")

vim.api.nvim_set_var("mapleader", [[\]])
vim.api.nvim_set_var("maplocalleader", [[|]])

require("lazy").setup({
  spec = {
    { import = "wuelnerdotexe.plugin.start" },
    -- { import = "wuelnerdotexe.plugin.opt" },
  },
  defaults = { lazy = true, version = false },
  dev = { path = "~/Developer/vim-plugins", patterns = { "wuelnerdotexe" }, fallback = true },
  install = { colorscheme = { "enfocado" } },
  ui = { border = "rounded", browser = "chrome", throttle = 42 },
  performance = {
    rtp = { disabled_plugins = { "gzip", "nvim", "man", "matchit", "tarPlugin", "tohtml", "tutor", "zipPlugin" } },
  },
})
