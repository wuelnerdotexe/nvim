return {
  "codota/tabnine-nvim",
  build = {
    vim.uv.os_uname().sysname == "Windows_NT" and [[pwsh.exe -file .\dl_binaries.ps1]] or "./dl_binaries.sh",
    ":TabnineHub",
  },
  cmd = { "TabnineChat", "TabnineDisable", "TabnineEnable", "TabnineHub", "TabnineStatus", "TabnineToggle" },
  event = { "BufEnter", "FileType" },
  config = function()
    require("tabnine").setup({
      disable_auto_comment = true,
      accept_keymap = "<C-]>",
      dismiss_keymap = "<C-[>",
      debounce_ms = vim.api.nvim_get_option_value("timeoutlen", { scope = "global" }),
      suggestion_color = {
        gui = require("wuelnerdotexe.plugin.util").get_scheme_color("LspCodeLens", "fg"),
        cterm = require("wuelnerdotexe.plugin.util").get_scheme_color("LspCodeLens", "ctermfg"),
      },
      exclude_filetypes = require("wuelnerdotexe.plugin.util").user_interface_filetypes,
    })
  end,
}
