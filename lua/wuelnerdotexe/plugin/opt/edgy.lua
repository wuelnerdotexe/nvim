return {
  {
    "folke/edgy.nvim",
    event = "UIEnter",
    init = function()
      require("wuelnerdotexe.plugin.util").add_colorscheme_integration("edgy")

      require("wuelnerdotexe.plugin.util").set_option("laststatus", 3)
      require("wuelnerdotexe.plugin.util").set_option("splitkeep", "screen")

      table.insert(require("wuelnerdotexe.plugin.util").user_interface_filetypes, "edgy")
    end,
    config = function()
      local sidebar_width = require("wuelnerdotexe.plugin.util").get_sidebar_width()

      require("edgy").setup({
        bottom = {
          { ft = "qf", title = "QuickFix", size = { height = 0.25 } },
          {
            ft = "help",
            filter = function(buf) return vim.api.nvim_get_option_value("buftype", { buf = buf }) == "help" end,
            title = "Help",
            size = { height = 0.5 },
          },
          {
            ft = "noice",
            filter = function(_, win) return vim.api.nvim_win_get_config(win).relative == "" end,
            title = "Noice",
            size = { height = 0.25 },
          },
          { ft = "spectre_panel", title = "Spectre", size = { height = 0.5 } },
        },
        right = {
          {
            ft = "neo-tree",
            filter = function(buf) return vim.api.nvim_buf_get_var(buf, "neo_tree_source") == "filesystem" end,
            open = function() require("neo-tree.command").execute({ source = "filesystem", dir = vim.loop.cwd() }) end,
            title = "FOLDERS",
            size = { height = 0.33 },
            pinned = true,
          },
          {
            ft = "neo-tree",
            filter = function(buf) return vim.api.nvim_buf_get_var(buf, "neo_tree_source") == "git_status" end,
            open = function() require("neo-tree.command").execute({ source = "git_status", dir = vim.loop.cwd() }) end,
            title = "GIT STATUS",
            size = { height = 0.33 },
            pinned = true,
          },
          {
            ft = "neo-tree",
            filter = function(buf) return vim.api.nvim_buf_get_var(buf, "neo_tree_source") == "document_symbols" end,
            open = function() require("neo-tree.command").execute({ source = "document_symbols", dir = vim.loop.cwd() }) end,
            title = "SYMBOLS",
            size = { height = 0.33 },
            pinned = true,
          },
        },
        options = {
          left = { size = sidebar_width },
          bottom = { size = 0.25 },
          top = { size = 0.25 },
          right = { size = sidebar_width },
        },
        animate = {
          fps = 60,
          cps = 150,
          on_begin = function() vim.api.nvim_set_var("minianimate_disable", true) end,
          on_end = function() vim.api.nvim_set_var("minianimate_disable", false) end,
          spinner = {
            frames = package.loaded["noice"] and require("noice.util.spinners").spinners.circleFull
              or { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
            interval = 67,
          },
        },
        exit_when_last = true,
        -- keys = { ["<C-q>"] = false, ["Q"] = false, ["]w"] = false, ["[w"] = false, ["]W"] = false, ["[W"] = false },
        icons = { closed = "", open = "" },
      })
    end,
  },
  {
    "bufferline.nvim",
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
  { "neo-tree.nvim", optional = true, opts = function(_, opts) opts.edgy = true end },
}
