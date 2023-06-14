return {
  "tzachar/cmp-tabnine",
  build = "./install.sh",
  dependencies = { "hrsh7th/nvim-cmp", "L3MON4D3/LuaSnip" },
  cmd = { "CmpTabnineHub", "CmpTabnineHubUrl", "CmpTabninePrefetch" },
  lazy = true,
  event = "InsertEnter",
  init = function()
    vim.api.nvim_create_autocmd("BufReadPre", {
      pattern = "*.css,*.sass,*.html,*.js,*.jsx,*.ts,*.tsx",
      callback = function(ev) require("cmp_tabnine"):prefetch(ev.file) end,
    })
  end,
  config = function()
    local ignored_file_types = {}

    for _, uifiletype in pairs(require("wuelnerdotexe.plugin.config").uifiletypes) do
      ignored_file_types[uifiletype] = true
    end

    require("cmp_tabnine.config"):setup({ ignored_file_types = ignored_file_types })
  end,
}
