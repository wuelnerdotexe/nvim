return {
  {
    "hrsh7th/nvim-cmp",
    lazy = true,
    config = function()
      vim.api.nvim_set_option_value("completeopt", "menu,menuone,noselect", require("wuelnerdotexe.utils").empty_table)

      require("cmp").setup({
        enabled = function()
          return (
            vim.api.nvim_get_option_value("buftype", { buf = 0 }) ~= "prompt"
            or (package.loaded["dap"] and require("cmp_dap").is_dap_buffer())
          )
            and vim.api.nvim_call_function("reg_recording", require("wuelnerdotexe.utils").empty_table) == ""
            and vim.api.nvim_call_function("reg_executing", require("wuelnerdotexe.utils").empty_table) == ""
        end,
        performance = { debounce = 42, throttle = 42, fetching_timeout = 284 },
        mapping = require("cmp").mapping.preset.insert(),
        snippet = { expand = function(args) require("luasnip").lsp_expand(args.body) end },
        formatting = {
          fields = { "abbr", "kind" },
          format = function(entry, vim_item)
            if vim_item.kind == "Color" and entry.completion_item.documentation then
              local _, _, r, g, b = string.find(entry.completion_item.documentation, "^rgb%((%d+), (%d+), (%d+)")

              if r and g and b then
                local color = string.format("%02x", r) .. string.format("%02x", g) .. string.format("%02x", b)
                local group = "Tw_" .. color

                if vim.api.nvim_call_function("hlID", { group }) < 1 then
                  vim.api.nvim_command("highlight" .. " " .. group .. " " .. "guifg=#" .. color)
                end

                vim_item.kind = "󱏿 Color"
                vim_item.kind_hl_group = group

                return vim_item
              end
            end

            vim_item.kind = entry.source.name == "cmp_tabnine" and " Tabnine"
              or require("wuelnerdotexe.utils").interface.codicons[vim_item.kind] .. " " .. vim_item.kind

            return vim_item
          end,
        },
        matching = { disallow_partial_fuzzy_matching = false },
        sorting = {
          comparators = {
            require("cmp.config.compare").scopes,
            require("cmp.config.compare").score,
            require("cmp.config.compare").exact,
            require("cmp.config.compare").order,
          },
        },
        sources = require("cmp").config.sources({
          { name = "path", keyword_length = 1, priority = 6 },
        }, {
          { name = "emmet", keyword_length = 1, priority = 5 },
          { name = "luasnip", keyword_length = 3, priority = 4 },
          { name = "nvim_lsp", keyword_length = 3, priority = 3 },
          { name = "cmp_tabnine", keyword_length = 3, priority = 2 },
        }, {
          {
            name = "buffer",
            option = {
              indexing_interval = 284,
              get_bufnrs = function()
                local current_buf = vim.api.nvim_get_current_buf()

                if vim.api.nvim_buf_get_offset(current_buf, vim.api.nvim_buf_line_count(current_buf)) > 1048576 then
                  return require("wuelnerdotexe.utils").empty_table
                end

                return { current_buf }
              end,
            },
            keyword_length = 3,
            priority = 1,
          },
        }),
        experimental = { ghost_text = true },
        window = {
          completion = { scrolloff = 3 },
          documentation = {
            border = require("wuelnerdotexe.utils").interface.border.style,
            winhighlight = "FloatBorder:FloatBorder",
          },
        },
      })

      require("cmp").event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())
      require("cmp").setup.filetype(require("wuelnerdotexe.utils").interface.filetypes, { enabled = false })
    end,
  },
  { "hrsh7th/cmp-buffer", event = "InsertEnter", dependencies = "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-path", event = "InsertEnter", dependencies = "hrsh7th/nvim-cmp" },
  {
    "hrsh7th/cmp-cmdline",
    event = "CmdlineEnter",
    dependencies = { "hrsh7th/nvim-cmp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path" },
    config = function()
      require("cmp").setup.cmdline({ "/", "?" }, {
        mapping = require("cmp").mapping.preset.cmdline(),
        sources = require("cmp").config.sources({ { name = "buffer", keyword_length = 1 } }),
      })

      require("cmp").setup.cmdline(":", {
        mapping = require("cmp").mapping.preset.cmdline(),
        sources = require("cmp").config.sources({
          { name = "path", keyword_length = 1 },
        }, {
          { name = "cmdline", keyword_length = 1 },
        }),
      })
    end,
  },
  {
    "tzachar/cmp-tabnine",
    build = "./install.sh",
    event = "InsertEnter",
    dependencies = "hrsh7th/nvim-cmp",
    config = function()
      local ignored_file_types = {}

      for _, filetype in ipairs(require("wuelnerdotexe.utils").interface.filetypes) do
        ignored_file_types[filetype] = true
      end

      vim.schedule(function() require("cmp_tabnine.config").setup({ ignored_file_types = ignored_file_types }) end)
    end,
  },
  { "saadparwaiz1/cmp_luasnip", event = "InsertEnter", dependencies = { "L3MON4D3/LuaSnip", "hrsh7th/nvim-cmp" } },
  { "jackieaskins/cmp-emmet", build = "npm run release", event = "InsertEnter", dependencies = "hrsh7th/nvim-cmp" },
}
