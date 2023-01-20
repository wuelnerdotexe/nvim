local call_function = vim.api.nvim_call_function
local lazypath = call_function("stdpath", { "data" }) .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  call_function("system", {
    { "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", lazypath },
  })
end

local rtp = vim.api.nvim_get_option_value("rtp", {})

vim.api.nvim_set_option_value("rtp", rtp == "" and lazypath or lazypath .. "," .. rtp, {})

require("lazy").setup("wuelner.plugins", {
  defaults = { lazy= true, version = false },
  dev = { path = "~/Workspace", patterns = { "wuelnerdotexe" } },
  install = { colorscheme = { "enfocado" } },
  ui = { border = "rounded", browser = "chrome", throttle = 40, custom_keys = { ["<localleader>l"] = false } },
  checker = { notify = false },
  change_detection = { enabled = false, notify = false },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
