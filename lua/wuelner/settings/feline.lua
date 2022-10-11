local M = {}

M.config = function()
  local vim_opt = vim.opt

  vim_opt.ruler = false
  vim_opt.laststatus = 2

  local components = { active = {}, inactive = {} }
  local vim_fn = vim.fn
  local enfocado = vim_fn['enfocado#getColorScheme']()

  local enfocado_hl = function(name, fg, style)
    local vi_mode = require('feline.providers.vi_mode')

    if vi_mode.get_mode_color() == 'bg_1'
    then
      return {
        name = name,
        fg = vi_mode.get_mode_color(),
        style = style
      }
    end

    return { name = name, fg = fg, style = style }
  end

  table.insert(components.active, {})
  table.insert(components.active, {})
  table.insert(components.active, {})
  table.insert(components.inactive, {})

  components.active[1][1] = {
    provider = 'diagnostic_errors',
    hl = function()
      return enfocado_hl('FelineErrors', 'br_red', 'bold')
    end,
    priority = -6,
    truncate_hide = true
  }

  components.active[1][2] = {
    provider = 'diagnostic_warnings',
    hl = function()
      return enfocado_hl('FelineWarns', 'br_orange', 'bold')
    end,
    priority = -6,
    truncate_hide = true
  }

  components.active[1][3] = {
    provider = 'diagnostic_info',
    hl = function()
      return enfocado_hl('FelineInfo', 'br_yellow', 'bold')
    end,
    priority = -6,
    truncate_hide = true
  }

  components.active[1][4] = {
    provider = 'diagnostic_hints',
    hl = function()
      return enfocado_hl('FelineHints', 'br_blue', 'bold')
    end,
    priority = -6,
    truncate_hide = true
  }

  components.active[1][5] = {
    enabled = function()
      return require('feline.providers.lsp').diagnostics_exist()
    end,
    provider = ' ',
    hl = { name = 'FelineDiagnosticsSeparator', fg = 'bg_1' },
    priority = -5
  }

  components.active[1][6] = {
    provider = '▊',
    hl = function()
      return enfocado_hl('FelineIndicator', 'accent_1', 'NONE')
    end,
    priority = 1
  }

  components.active[1][7] = {
    provider = {
      name = 'position',
      opts = { padding = { line = 2, col = 2 } }
    },
    left_sep = ' ',
    right_sep = ' ',
    hl = function()
      return enfocado_hl('FelinePosition', 'fg_0', 'NONE')
    end,
    truncate_hide = true
  }

  components.active[1][8] = {
    provider = '%P/%L',
    right_sep = ' ',
    hl = function()
      return enfocado_hl('FelineLines', 'fg_0', 'NONE')
    end,
    priority = -2,
    truncate_hide = true
  }

  components.active[1][9] = {
    provider = function()
      return ' ' .. vim_fn.fnamemodify(vim_fn.getcwd(), ':t')
    end,
    left_sep = ' ',
    right_sep = ' ',
    hl = function()
      return enfocado_hl('FelineCWD', 'br_blue', 'bold')
    end,
    priority = -8,
    truncate_hide = true
  }

  components.active[2][1] = {
    provider = 'git_branch',
    hl = function()
      return enfocado_hl('FelineBranch', 'br_orange', 'NONE')
    end,
    priority = -7,
    truncate_hide = true
  }

  components.active[2][2] = {
    provider = 'git_diff_added',
    hl = function()
      return enfocado_hl('FelineAdded', 'green', 'NONE')
    end,
    priority = -9,
    truncate_hide = true
  }

  components.active[2][3] = {
    provider = 'git_diff_removed',
    hl = function()
      return enfocado_hl('FelineRemoved', 'red', 'NONE')
    end,
    priority = -9,
    truncate_hide = true
  }

  components.active[2][4] = {
    provider = 'git_diff_changed',
    right_sep = ' ',
    hl = function()
      return enfocado_hl('FelineChanged', 'yellow', 'NONE')
    end,
    priority = -9,
    truncate_hide = true
  }

  components.active[3][1] = {
    provider = 'file_type',
    left_sep = ' ',
    right_sep = ' ',
    hl = function()
      return enfocado_hl('FelineFiletype', 'fg_0', 'NONE')
    end,
    priority = -4,
    truncate_hide = true
  }

  components.active[3][2] = {
    provider = 'file_encoding',
    right_sep = ' ',
    hl = function()
      return enfocado_hl('FelineEncoding', 'fg_0', 'NONE')
    end,
    priority = -1,
    truncate_hide = true
  }

  components.active[3][3] = {
    provider = function() return string.upper(vim_fn.SleuthIndicator()) end,
    right_sep = ' ',
    hl = function()
      return enfocado_hl('FelineSleuth', 'fg_0', 'NONE')
    end,
    priority = -3,
    truncate_hide = true
  }

  components.active[3][4] = {
    provider = 'file_format',
    right_sep = ' ',
    hl = function()
      return enfocado_hl('FelineFormat', 'fg_0', 'NONE')
    end,
    priority = -1,
    truncate_hide = true
  }

  components.inactive[1][1] = {
    provider = '▊',
    hl = { name = 'FelineIndicatorInactive', fg = 'bg_1' },
    priority = 1
  }

  components.inactive[1][2] = {
    provider = {
      name = 'position',
      opts = { padding = { line = 2, col = 2 } }
    },
    left_sep = ' ',
    right_sep = ' ',
    hl = { name = 'FelinePositionInactive', fg = 'dim_0' },
    truncate_hide = true
  }

  components.inactive[1][3] = {
    provider = 'file_info',
    icon = '',
    left_sep = ' ',
    hl = { name = 'FelineFilenameInactive', fg = 'dim_0' },
    priority = -1,
    truncate_hide = true
  }

  local feline = require('feline')

  feline.setup({
    theme = {
      bg_1 = enfocado.bg_1[1],
      dim_0 = enfocado.dim_0[1],
      fg_0 = enfocado.fg_0[1],
      red = enfocado.red[1],
      green = enfocado.green[1],
      yellow = enfocado.yellow[1],
      br_red = enfocado.br_red[1],
      br_yellow = enfocado.br_yellow[1],
      br_blue = enfocado.br_blue[1],
      br_orange = enfocado.br_orange[1],
      accent_1 = enfocado.accent_1[1]
    },
    vi_mode_colors = {
      ['COMMAND'] = 'bg_1',
      ['NONE'] = 'bg_1',
      ['SHELL'] = 'bg_1',
      ['TERM'] = 'bg_1'
    },
    components = components,
    force_inactive = {
      filetypes = {},
      buftypes = {
        '^help$',
        '^loclist$',
        '^nofile$',
        '^nowrite$',
        '^prompt$',
        '^quickfix$',
        '^terminal$'
      }
    },
    disable = { filetypes = { '^aerial$', '^fern$' }, buftypes = {} }
  })

  local AerialBreadcrumbs = require('wuelner.utils').AerialBreadcrumbs

  feline.winbar.setup({
    components = {
      active = {{{
        provider = function() return AerialBreadcrumbs() end,
        left_sep = ' ',
        hl = { name = 'FelineWinbar', fg = 'fg_0' }
      }}},
      inactive = {{{
        provider = function() return AerialBreadcrumbs() end,
        left_sep = ' ',
        hl = { name = 'FelineInactiveWinbar', fg = 'dim_0' }
      }}}
    },
    disable = {
      buftypes = {
        '^help$',
        '^loclist$',
        '^nofile$',
        '^nowrite$',
        '^prompt$',
        '^quickfix$',
        '^terminal$'
      }
    }
  })
end

return M

