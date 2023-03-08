return {
  "wuelnerdotexe/nerdterm",
  enabled = not require("wuelnerdotexe.plugin.config").minimal_setup,
  keys = { { "<leader>tt", "<Plug>(NERDTermToggle)" } },
}
