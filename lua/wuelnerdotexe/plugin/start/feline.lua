return {
  "freddiehaddad/feline.nvim",
  dependencies = "nvim-tree/nvim-web-devicons",
  event = "UIEnter",
  init = function()
    require("wuelnerdotexe.plugin.util").set_option("termguicolors", true)
    require("wuelnerdotexe.plugin.util").set_option("laststatus", 3)
    require("wuelnerdotexe.plugin.util").set_option("ruler", false)
  end,
  config = function()
    local scheme_colors_loaded = {}

    local function get_scheme_color(name, attr)
      local hl = vim.api.nvim_get_hl(0, { name = name, link = false })[attr]

      if hl == nil then return "NONE" end

      if scheme_colors_loaded[hl] then return scheme_colors_loaded[hl] end

      if type(hl) == "string" then
        scheme_colors_loaded[hl] = hl

        return scheme_colors_loaded[hl]
      end

      scheme_colors_loaded[hl] = string.format("#%06x", hl)

      return scheme_colors_loaded[hl]
    end

    require("feline").setup({
      theme = {
        bg = get_scheme_color("Normal", "bg"),
        fg = get_scheme_color("Normal", "fg"),
        base = get_scheme_color("FloatShadow", "bg"),
        black = get_scheme_color("CursorLine", "bg"),
        darkred = get_scheme_color("diffRemoved", "fg"),
        darkgreen = get_scheme_color("diffAdded", "fg"),
        darkyellow = get_scheme_color("diffChanged", "fg"),
        oceanblue = get_scheme_color("SpellCap", "sp"),
        darkmagenta = get_scheme_color("SpellRare", "sp"),
        darkcyan = get_scheme_color("SpellLocal", "sp"),
        darkorange = get_scheme_color("Exception", "fg"),
        darkviolet = get_scheme_color("Identifier", "fg"),
        gray = get_scheme_color("Comment", "fg"),
        darkaccent = get_scheme_color("Identifier", "fg"),
        darkgray = get_scheme_color("Ignore", "fg"),
        red = get_scheme_color("DiagnosticError", "fg"),
        green = get_scheme_color("DiagnosticOk", "fg"),
        yellow = get_scheme_color("DiagnosticInfo", "fg"),
        skyblue = get_scheme_color("DiagnosticHint", "fg"),
        magenta = get_scheme_color("Trace", "fg"),
        cyan = get_scheme_color("Link", "fg"),
        orange = get_scheme_color("WarningMsg", "fg"),
        violet = get_scheme_color("Function", "fg"),
        white = get_scheme_color("Title", "fg"),
        accent = get_scheme_color("FloatBorder", "fg"),
      },
      vi_mode_colors = {
        ["BLOCK"] = "accent",
        ["COMMAND"] = "accent",
        ["CONFIRM"] = "yellow",
        ["ENTER"] = "accent",
        ["INSERT"] = "accent",
        ["LINES"] = "accent",
        ["MORE"] = "yellow",
        ["NONE"] = "accent",
        ["NORMAL"] = "accent",
        ["OP"] = "accent",
        ["REPLACE"] = "accent",
        ["SELECT"] = "accent",
        ["SHELL"] = "accent",
        ["TERM"] = "accent",
        ["VISUAL"] = "accent",
        ["V-REPLACE"] = "accent",
      },
      highlight_reset_triggers = { "ColorScheme" },
      components = {
        active = {
          {
            {
              provider = "diagnostic_errors",
              icon = " E:",
              hl = { name = "FelineErrors", bg = "base", fg = "red", style = "bold" },
              priority = -6,
              truncate_hide = true,
            },
            {
              provider = "diagnostic_warnings",
              icon = " W:",
              hl = { name = "FelineWarns", bg = "base", fg = "orange", style = "bold" },
              priority = -6,
              truncate_hide = true,
            },
            {
              provider = "diagnostic_info",
              icon = " I:",
              hl = { name = "FelineInfo", bg = "base", fg = "yellow", style = "bold" },
              priority = -6,
              truncate_hide = true,
            },
            {
              provider = "diagnostic_hints",
              icon = " H:",
              hl = { name = "FelineHints", bg = "base", fg = "skyblue", style = "bold" },
              priority = -6,
              truncate_hide = true,
            },
            {
              enabled = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
              update = function() return require("noice").api.status.mode.has() end,
              provider = function() return tostring(require("noice").api.status.mode.get()) end,
              left_sep = { str = " ", hl = { bg = "base" } },
              hl = function()
                return {
                  name = require("feline.providers.vi_mode").get_mode_highlight_name(),
                  fg = require("feline.providers.vi_mode").get_mode_color(),
                  bg = "base",
                }
              end,
              priority = 1,
            },
            {
              enabled = function()
                return require("feline.providers.lsp").diagnostics_exist()
                  or (package.loaded["noice"] and require("noice").api.status.mode.has())
              end,
              update = function()
                return require("feline.providers.lsp").diagnostics_exist() or require("noice").api.status.mode.has()
              end,
              provider = " ",
              hl = { name = "FelineSidebar", bg = "base", fg = "bg" },
              priority = -5,
            },
            {
              update = false,
              provider = "▎",
              hl = { name = "FelineIndicator", fg = "accent" },
              priority = 2,
            },
            {
              enabled = function() return vim.api.nvim_get_option_value("cmdheight", {}) == 0 end,
              provider = { name = "vi_mode", opts = { padding = "center" } },
              left_sep = " ",
              hl = function()
                return {
                  name = require("feline.providers.vi_mode").get_mode_highlight_name(),
                  fg = require("feline.providers.vi_mode").get_mode_color(),
                  style = "bold",
                }
              end,
              icon = "",
              priority = 1,
            },
            {
              provider = { name = "position", opts = { padding = { line = 3, col = 2 } } },
              left_sep = " ",
              right_sep = " ",
              hl = { name = "FelinePosition" },
              truncate_hide = true,
            },
            {
              provider = "%P/%L",
              right_sep = " ",
              hl = { name = "FelineLines" },
              priority = -2,
              truncate_hide = true,
            },
            {
              enabled = function()
                return vim.api.nvim_get_option_value("showcmd", {}) == true
                  and vim.api.nvim_get_option_value("showcmdloc", {}) == "statusline"
              end,
              provider = "%S",
              left_sep = " ",
              right_sep = " ",
              hl = { name = "FelineCMD", fg = "gray" },
              priority = -9,
              truncate_hide = true,
            },
          },
          {
            {
              provider = "git_branch",
              icon = " ",
              hl = { name = "FelineBranch", fg = "orange" },
              priority = -7,
              truncate_hide = true,
            },
            {
              provider = "git_diff_added",
              icon = "  ",
              hl = { name = "FelineAdded", fg = "darkgreen" },
              priority = -8,
              truncate_hide = true,
            },
            {
              provider = "git_diff_removed",
              icon = "  ",
              hl = { name = "FelineRemoved", fg = "darkred" },
              priority = -8,
              truncate_hide = true,
            },
            {
              provider = "git_diff_changed",
              icon = "  ",
              right_sep = " ",
              hl = { name = "FelineChanged", fg = "darkyellow" },
              priority = -8,
              truncate_hide = true,
            },
          },
          {
            { provider = " ", priority = -4, truncate_hide = true },
            {
              enabled = function() return package.loaded["tabnine"] end,
              update = function() return require("tabnine.status").status() end,
              provider = "⌬ ",
              right_sep = " ",
              hl = function()
                local tabnine_status = require("tabnine.status").status()

                if string.match(tabnine_status, "disabled") then
                  return { name = "FelineTabnineDisabled", fg = "darkgray" }
                end

                if string.match(tabnine_status, "loading") then
                  return { name = "FelineTabnineLoading", fg = "gray" }
                end

                return { name = "FelineTabnine", fg = "violet" }
              end,
              priority = -4,
              truncate_hide = true,
            },
            {
              update = { "FileType" },
              provider = "file_type",
              right_sep = " ",
              hl = { name = "FelineFiletype" },
              priority = -4,
              truncate_hide = true,
            },
            {
              provider = "file_encoding",
              right_sep = " ",
              hl = { name = "FelineEncoding" },
              priority = -1,
              truncate_hide = true,
            },
            {
              provider = function()
                local shiftwidth = vim.api.nvim_call_function("shiftwidth", {})

                if vim.api.nvim_get_option_value("expandtab", { buf = 0 }) then
                  return string.upper("Spaces:" .. shiftwidth)
                end

                local tabstop = vim.api.nvim_get_option_value("tabstop", { buf = 0 })

                if shiftwidth == tabstop then return string.upper("Tabs:" .. tabstop) end

                return string.upper("Spaces:" .. shiftwidth .. "," .. "Tabs:" .. tabstop)
              end,
              right_sep = " ",
              hl = { name = "FelineIndent" },
              priority = -3,
              truncate_hide = true,
            },
            {
              provider = "file_format",
              right_sep = " ",
              hl = { name = "FelineFormat" },
              priority = -1,
              truncate_hide = true,
            },
          },
        },
        inactive = {
          {
            { update = false, provider = "▎", hl = { name = "FelineIndicatorInactive", fg = "bg" }, priority = 1 },
            {
              provider = { name = "position", opts = { padding = { line = 3, col = 2 } } },
              left_sep = " ",
              right_sep = " ",
              hl = { name = "FelinePositionInactive", fg = "gray" },
              truncate_hide = true,
            },
            {
              provider = { name = "file_info", opts = { file_readonly_icon = " " } },
              icon = " ",
              left_sep = " ",
              hl = { name = "FelineFilenameInactive", fg = "gray" },
              priority = -1,
              truncate_hide = true,
            },
          },
        },
      },
      disable = {
        buftypes = { "^help$", "^loclist$", "^nofile$", "^prompt$", "^quickfix$", "^terminal$" },
        filetypes = { "^netrw$" },
      },
    })

    vim.api.nvim_create_autocmd("OptionSet", {
      pattern = "background",
      callback = function() require("feline").reset_highlights() end,
    })
  end,
}
