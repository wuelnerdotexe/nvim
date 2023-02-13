local lazypath = vim.api.nvim_call_function("stdpath", { "data" }) .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.api.nvim_call_function("system", {
    { "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", lazypath },
  })
end

local rtp = vim.api.nvim_get_option_value("rtp", {})

vim.api.nvim_set_option_value("rtp", rtp == "" and lazypath or lazypath .. "," .. rtp, {})

require("lazy").setup({
  spec = { { import = "wuelnerdotexe.plugin" }, { import = "wuelnerdotexe.plugin.fancy" } },
  defaults = { lazy = true, version = false },
  dev = { path = "~/Workspace", patterns = { "wuelnerdotexe" }, fallback = true },
  install = { colorscheme = { "enfocado" } },
  ui = { border = "rounded", browser = "chrome", throttle = 40, custom_keys = { ["<localleader>l"] = false } },
  performance = {
    rtp = {
      disabled_plugins = { "gzip", "matchit", "matchparen", "netrwPlugin", "tarPlugin", "tohtml", "tutor", "zipPlugin" },
    },
  },
})
