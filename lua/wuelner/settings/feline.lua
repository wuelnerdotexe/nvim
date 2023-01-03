local config = function()
  local tbl = {}

  vim.api.nvim_set_option_value("ruler", false, tbl)

  local components = { active = {}, inactive = {} }
  local components_active = components.active
  local table_insert = table.insert
  local call_function = vim.api.nvim_call_function

  table_insert(components_active, {})
  table_insert(components_active, {})
  table_insert(components_active, {})

  components_active[1][1] = {
    provider = "diagnostic_errors",
    icon = " E:",
    hl = { name = "FelineErrors", bg = "base", fg = "red", style = "bold" },
    priority = -6,
    truncate_hide = true,
  }

  components_active[1][2] = {
    provider = "diagnostic_warnings",
    icon = " W:",
    hl = { name = "FelineWarns", bg = "base", fg = "orange", style = "bold" },
    priority = -6,
    truncate_hide = true,
  }

  components_active[1][3] = {
    provider = "diagnostic_info",
    icon = " I:",
    hl = { name = "FelineInfo", bg = "base", fg = "yellow", style = "bold" },
    priority = -6,
    truncate_hide = true,
  }

  components_active[1][4] = {
    provider = "diagnostic_hints",
    icon = " H:",
    hl = { name = "FelineHints", bg = "base", fg = "skyblue", style = "bold" },
    priority = -6,
    truncate_hide = true,
  }

  components_active[1][5] = {
    enabled = function()
      return require("feline.providers.lsp").diagnostics_exist()
    end,
    provider = " ",
    hl = { name = "FelineDiagnosticsSeparator", bg = "base", fg = "bg" },
    priority = -5,
  }

  components_active[1][6] = {
    provider = "▎",
    hl = { name = "FelineIndicator", fg = "accent" },
    priority = 2,
  }

  components_active[1][7] = {
    enabled = function()
      return vim.api.nvim_get_option_value("cmdheight", tbl) == 0
    end,
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
  }

  components_active[1][8] = {
    provider = { name = "position", opts = { padding = { line = 3, col = 2 } } },
    left_sep = " ",
    right_sep = " ",
    hl = { name = "FelinePosition" },
    truncate_hide = true,
  }

  components_active[1][9] = {
    provider = "%P/%L",
    right_sep = " ",
    hl = { name = "FelineLines" },
    priority = -2,
    truncate_hide = true,
  }

  components_active[2][1] = {
    provider = "git_branch",
    icon = " ",
    hl = { name = "FelineBranch", fg = "orange" },
    priority = -7,
    truncate_hide = true,
  }

  components_active[2][2] = {
    provider = "git_diff_added",
    icon = "  ",
    hl = { name = "FelineAdded", fg = "darkgreen" },
    priority = -8,
    truncate_hide = true,
  }

  components_active[2][3] = {
    provider = "git_diff_removed",
    icon = "  ",
    hl = { name = "FelineRemoved", fg = "darkred" },
    priority = -8,
    truncate_hide = true,
  }

  components_active[2][4] = {
    provider = "git_diff_changed",
    icon = "  ",
    right_sep = " ",
    hl = { name = "FelineChanged", fg = "darkyellow" },
    priority = -8,
    truncate_hide = true,
  }

  components_active[3][1] = {
    provider = "file_type",
    right_sep = " ",
    hl = { name = "FelineFiletype" },
    priority = -4,
    truncate_hide = true,
  }

  components_active[3][2] = {
    provider = "file_encoding",
    right_sep = " ",
    hl = { name = "FelineEncoding" },
    priority = -1,
    truncate_hide = true,
  }

  components_active[3][3] = {
    provider = function()
      return string.upper(call_function("SleuthIndicator", tbl))
    end,
    right_sep = " ",
    hl = { name = "FelineSleuth" },
    priority = -3,
    truncate_hide = true,
  }

  components_active[3][4] = {
    provider = "file_format",
    right_sep = " ",
    hl = { name = "FelineFormat" },
    priority = -1,
    truncate_hide = true,
  }

  local components_inactive = components.inactive

  table_insert(components_inactive, {})

  components_inactive[1][1] = { provider = "▎", hl = { name = "FelineIndicatorInactive", fg = "bg" }, priority = 1 }

  components_inactive[1][2] = {
    provider = { name = "position", opts = { padding = { line = 3, col = 2 } } },
    left_sep = " ",
    right_sep = " ",
    hl = { name = "FelinePositionInactive", fg = "gray" },
    truncate_hide = true,
  }

  components_inactive[1][3] = {
    provider = { name = "file_info", opts = { file_readonly_icon = " " } },
    icon = "",
    left_sep = " ",
    hl = { name = "FelineFilenameInactive", fg = "gray" },
    priority = -1,
    truncate_hide = true,
  }

  local enfocado_colors = call_function("enfocado#getColorScheme", tbl)

  require("feline").setup({
    theme = {
      base = enfocado_colors.base[1],
      bg = enfocado_colors.bg_0[1],
      fg = enfocado_colors.fg_0[1],
      accent = enfocado_colors.br_accent_0[1],
      black = enfocado_colors.bg_1[1],
      darkred = enfocado_colors.red[1],
      darkgreen = enfocado_colors.green[1],
      darkyellow = enfocado_colors.yellow[1],
      oceanblue = enfocado_colors.blue[1],
      darkmagenta = enfocado_colors.magenta[1],
      darkcyan = enfocado_colors.cyan[1],
      darkorange = enfocado_colors.orange[1],
      darkviolet = enfocado_colors.violet[1],
      gray = enfocado_colors.dim_0[1],
      darkgray = enfocado_colors.bg_2[1],
      red = enfocado_colors.br_red[1],
      green = enfocado_colors.br_green[1],
      yellow = enfocado_colors.br_yellow[1],
      skyblue = enfocado_colors.br_blue[1],
      magenta = enfocado_colors.br_magenta[1],
      cyan = enfocado_colors.br_cyan[1],
      orange = enfocado_colors.br_orange[1],
      violet = enfocado_colors.br_violet[1],
      white = enfocado_colors.fg_1[1],
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
    components = components,
    force_inactive = { filetypes = { "^nerdterm$" }, buftypes = { "^help$", "^loclist$", "^nofile$", "^quickfix$" } },
    disable = { filetypes = { "^aerial$", "^fern$" }, buftypes = { "^prompt$" } },
  })

  local aerial_breadcrumbs = require("wuelner.utils").aerial_breadcrumbs

  require("feline").winbar.setup({
    components = {
      active = {
        {
          {
            provider = function()
              return aerial_breadcrumbs()
            end,
            left_sep = " ",
            right_sep = " ",
            hl = { name = "FelineWinbar", fg = "fg" },
          },
        },
      },
      inactive = {
        {
          {
            provider = function()
              return aerial_breadcrumbs()
            end,
            left_sep = " ",
            right_sep = " ",
            hl = { name = "FelineInactiveWinbar", fg = "gray" },
          },
        },
      },
    },
    disable = { buftypes = { "^help$", "^loclist$", "^nofile$", "^prompt$", "^quickfix$", "^terminal$" } },
  })
end

return config
