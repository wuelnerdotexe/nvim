return {
  {
    "folke/edgy.nvim",
    ft = { "help", "qf" },
    init = function()
      require("wuelnerdotexe.plugin.util").add_colorscheme_integration("edgy")

      require("wuelnerdotexe.plugin.util").set_option("laststatus", 3)
      require("wuelnerdotexe.plugin.util").set_option("splitkeep", "screen")

      table.insert(require("wuelnerdotexe.plugin.util").user_interface_filetypes, "edgy")
    end,
    opts = function(_, opts)
      opts.options = {
        left = { size = function() return require("wuelnerdotexe.plugin.util").get_sidebar_width() end },
        bottom = { size = 0.25 },
        right = { size = function() return require("wuelnerdotexe.plugin.util").get_sidebar_width() end },
        top = { size = 0.25 },
      }

      opts.animate = vim.tbl_deep_extend("error", opts.animate or {}, {
        fps = 60,
        cps = 150,
        on_begin = function() vim.api.nvim_set_var("minianimate_disable", true) end,
        on_end = function() vim.api.nvim_set_var("minianimate_disable", false) end,
      })

      opts.exit_when_last = true

      opts.icons = { closed = "", open = "" }

      opts.bottom = vim.list_extend(opts.bottom or {}, {
        { ft = "qf", title = "QuickFix", size = { height = 0.25 } },
        {
          ft = "help",
          filter = function(buf) return vim.api.nvim_get_option_value("buftype", { buf = buf }) == "help" end,
          title = "Help",
          size = { height = 0.5 },
        },
      })
    end,
    config = function(_, opts) require("edgy").setup(opts) end,
  },
  {
    "akinsho/bufferline.nvim",
    optional = true,
    opts = function()
      if not require("bufferline.offset").edgy then
        local ref_get = require("bufferline.offset").get

        require("bufferline.offset").get = function()
          if package.loaded["edgy"] then
            local ret = { left = "", left_size = 0, right = "", right_size = 0 }

            for _, pos in ipairs({ "left", "right" }) do
              if require("edgy.config").layout[pos] and #require("edgy.config").layout[pos].wins > 0 then
                local fills = string.rep(" ", (math.floor(require("edgy.config").layout[pos].bounds.width - 7) / 2))

                ret[pos] = "%#Ignore#" .. fills .. "SIDEBAR" .. fills
                ret[pos .. "_size"] = require("edgy.config").layout[pos].bounds.width
              end
            end

            ret.total_size = ret.left_size + ret.right_size

            if ret.total_size > 0 then return ret end
          end

          return ref_get()
        end

        require("bufferline.offset").edgy = true
      end
    end,
  },
  {
    "petertriho/nvim-scrollbar",
    optional = true,
    opts = function(_, opts) opts.excluded_filetypes = vim.list_extend(opts.excluded_filetypes or {}, { "edgy" }) end,
  },
}
