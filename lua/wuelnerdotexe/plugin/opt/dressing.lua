return {
  {
    "stevearc/dressing.nvim",
    lazy = true,
    init = function()
      vim.opt.listchars:append({ precedes = "…", extends = "…" })

      vim.list_extend(
        require("wuelnerdotexe.plugin.util").user_interface_filetypes,
        { "DressingInput", "DressingSelect" }
      )

      vim.ui.input = function(...)
        if package.loaded["dressing.nvim"] then return vim.ui.input(...) end

        require("lazy").load({ plugins = { "dressing.nvim" } })

        return vim.ui.input(...)
      end

      vim.ui.select = function(...)
        if package.loaded["dressing.nvim"] then return vim.ui.select(...) end

        require("lazy").load({ plugins = { "dressing.nvim" } })

        return vim.ui.select(...)
      end
    end,
    config = function()
      local winblend = vim.api.nvim_get_option_value("winblend", { scope = "global" })

      require("dressing").setup({
        input = {
          win_options = {
            winblend = winblend,
            list = vim.api.nvim_get_option_value("list", { scope = "global" }),
            sidescrolloff = vim.api.nvim_get_option_value("sidescrolloff", { scope = "global" }),
          },
        },
        select = {
          backend = { "telescope", "fzf", "nui", "builtin" },
          nui = { win_options = { winblend = winblend, cursorline = true, winhighlight = "CursorLine:PmenuSel" } },
          builtin = { win_options = { winblend = winblend, cursorline = true, winhighlight = "CursorLine:PmenuSel" } },
        },
      })
    end,
  },
  {
    "mrjones2014/smart-splits.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ignored_filetypes = vim.list_extend(opts.ignored_filetypes or {}, { "DressingInput", "DressingSelect" })
    end,
  },
  {
    "petertriho/nvim-scrollbar",
    optional = true,
    opts = function(_, opts)
      opts.excluded_filetypes = vim.list_extend(opts.excluded_filetypes or {}, { "DressingInput", "DressingSelect" })
    end,
  },
}
