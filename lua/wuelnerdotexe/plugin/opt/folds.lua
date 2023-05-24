return {
  {
    "anuvyklack/pretty-fold.nvim",
    event = require("wuelnerdotexe.plugin.config").open_file_event,
    config = function()
      require("pretty-fold").setup({
        sections = {
          left = {
            "━" .. " ",
            function() return string.rep("*", vim.api.nvim_get_vvar("foldlevel")) end,
            " " .. "━┫" .. " ",
            "content",
            " " .. "┣━",
          },
          right = { "━┫" .. " ", "number_of_folded_lines", ":" .. " ", "percentage", " " .. "┣━" },
        },
        fill_char = "━",
        keep_indentation = false,
      })
    end,
  },
  {
    "anuvyklack/fold-preview.nvim",
    keys = {
      {
        "<leader>fp",
        function() require("fold-preview").show_preview() end,
        desc = "Folds: [p]review the current [f]old",
      },
    },
    dependencies = "anuvyklack/keymap-amend.nvim",
    config = function()
      require("fold-preview").setup({ border = require("wuelnerdotexe.plugin.config").border == "rounded" or "shadow" })
    end,
  },
}
