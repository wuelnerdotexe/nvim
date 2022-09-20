local M = {}

M.config = function()
  local components = { active = {}, inactive = {} }
  local vim_fn = vim.fn
  local enfocado = vim_fn['enfocado#getColorScheme']()
  local vi_mode = require('feline.providers.vi_mode')

  table.insert(components.active, {})
  table.insert(components.active, {})
  table.insert(components.inactive, {})

  components.active[1][1] = {
    provider = '▊',
    hl = { name = 'FelineIndicator', fg = 'accent' },
    priority = 2
  }

  components.active[1][2] = {
    provider = {
      name = 'position',
      opts = { padding = { line = 2, col = 2 } }
    },
    left_sep = ' ',
    right_sep = ' ',
    hl = function()
      return {
        name = vi_mode.get_mode_highlight_name(),
        fg = vi_mode.get_mode_color()
      }
    end,
    priority = 1
  }

  components.active[1][3] = {
    provider = function()
      return ' ' .. vim_fn.fnamemodify(vim_fn.getcwd(), ':t')
    end,
    left_sep = ' ',
    right_sep = ' ',
    hl = { name = 'FelineCWD', fg = 'accent' },
    priority = 1
  }

  components.active[1][4] = {
    provider = 'git_branch',
    left_sep = ' ',
    hl = { name = 'FelineBranch', fg = 'accent' },
    priority = -2,
    truncate_hide = true
  }

  components.active[1][5] = {
    provider = 'git_diff_added',
    icon = ' + ',
    hl = { name = 'FelineAdded', fg = 'added' },
    priority = -2,
    truncate_hide = true
  }

  components.active[1][6] = {
    provider = 'git_diff_removed',
    icon = ' - ',
    hl = { name = 'FelineRemoved', fg = 'removed' },
    priority = -2,
    truncate_hide = true
  }

  components.active[1][7] = {
    provider = 'git_diff_changed',
    icon = ' ~ ',
    right_sep = ' ',
    hl = { name = 'FelineChanged', fg = 'changed' },
    priority = -2,
    truncate_hide = true
  }

  components.active[1][8] = {
    provider = 'diagnostic_errors',
    hl = { name = 'FelineErrors', fg = 'errors', style = 'bold' },
    left_sep = ' ',
    priority = -1,
    truncate_hide = true
  }

  components.active[1][9] = {
    provider = 'diagnostic_warnings',
    hl = { name = 'FelineWarns', fg = 'warns', style = 'bold' },
    priority = -1,
    truncate_hide = true
  }

  components.active[1][10] = {
    provider = 'diagnostic_info',
    hl = { name = 'FelineInfo', fg = 'info', style = 'bold' },
    priority = -1,
    truncate_hide = true
  }

  components.active[1][11] = {
    provider = 'diagnostic_hints',
    right_sep = ' ',
    hl = { name = 'FelineHints', fg = 'hints', style = 'bold' },
    priority = -1,
    truncate_hide = true
  }

  components.active[2][1] = {
    provider = 'file_encoding',
    left_sep = ' ',
    right_sep = ' ',
    hl = { name = 'FelineFileencoding', fg = 'accent_2' }
  }

  components.active[2][2] = {
    provider = 'file_type',
    right_sep = ' ',
    hl = { name = 'FelineFiletype', fg = 'accent_2' },
    priority = -3,
    truncate_hide = true
  }

  components.active[2][3] = {
    provider = function() return string.upper(vim_fn.SleuthIndicator()) end,
    right_sep = ' ',
    hl = { name = 'FelineSleuth', fg = 'accent_2' },
    priority = -3,
    truncate_hide = true
  }

  components.active[2][4] = {
    provider = 'file_format',
    right_sep = ' ',
    hl = { name = 'FelineFileformat', fg = 'accent_2' }
  }

  components.inactive[1][1] = {
    provider = '▊',
    hl = { name = 'FelineIndicatorInactive', fg = 'ignored' },
    priority = 1
  }

  components.inactive[1][2] = {
    provider = {
      name = 'position',
      opts = { padding = { line = 2, col = 2 } }
    },
    left_sep = ' ',
    right_sep = ' ',
    hl = { name = 'FelinePositionInactive', fg = 'dimmed' }
  }

  components.inactive[1][3] = {
    provider = 'file_info',
    icon = '',
    left_sep = ' ',
    hl = { name = 'FelineFilenameInactive', fg = 'dimmed' },
    priority = -1
  }

  require('feline').setup({
    components = components,
    theme = {
      accent = enfocado.br_accent_1[1],
      accent_2 = enfocado.accent_2[1],
      dimmed = enfocado.dim_0[1],
      ignored = enfocado.bg_1[1],
      added = enfocado.green[1],
      removed = enfocado.red[1],
      changed = enfocado.yellow[1],
      errors = enfocado.br_red[1],
      warnings = enfocado.br_orange[1],
      info = enfocado.br_yellow[1],
      hints = enfocado.br_blue[1]
    },
    vi_mode_colors = {
      ['NORMAL'] = 'accent',
      ['OP'] = 'changed',
      ['INSERT'] = 'added',
      ['VISUAL'] = 'hints',
      ['LINES'] = 'hints',
      ['BLOCK'] = 'hints',
      ['REPLACE'] = 'changed',
      ['V-REPLACE'] = 'changed',
      ['ENTER'] = 'added',
      ['MORE'] = 'info',
      ['SELECT'] = 'hints',
      ['COMMAND'] = 'dimmed',
      ['SHELL'] = 'dimmed',
      ['TERM'] = 'dimmed',
      ['NONE'] = 'dimmed'
    },
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
    disable = { filetypes = { '^fern$' }, buftypes = {} }
  })
end

return M

