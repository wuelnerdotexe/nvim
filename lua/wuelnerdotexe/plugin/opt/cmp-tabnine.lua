return {
  "tzachar/cmp-tabnine",
  build = "./install.sh",
  dependencies = {
    "hrsh7th/nvim-cmp",
    dependencies = "L3MON4D3/LuaSnip",
    opts = function()
      require("wuelnerdotexe.plugin.start.cmp.util").completion_icons =
        vim.tbl_extend("error", require("wuelnerdotexe.plugin.start.cmp.util").completion_icons, { Tabnine = " " })

      local ref_format = require("wuelnerdotexe.plugin.start.cmp.util").formatting.format

      require("wuelnerdotexe.plugin.start.cmp.util").formatting.format = function(entry, vim_item)
        if entry.source.name == "cmp_tabnine" then
          vim_item.kind = require("wuelnerdotexe.plugin.start.cmp.util").completion_icons["Tabnine"] .. "Tabnine"

          return vim_item
        end

        return ref_format(entry, vim_item)
      end
    end,
  },
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
    local ignored_file_types = { [""] = true }

    for _, ui_ft in pairs(require("wuelnerdotexe.plugin.util").user_interface_filetypes) do
      ignored_file_types[ui_ft] = true
    end

    require("cmp_tabnine.config"):setup({
      snippet_placeholder = " ⋯ ",
      ignored_file_types = ignored_file_types,
    })
  end,
}
