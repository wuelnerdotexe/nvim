local M = {}

M.config = function()
  local galaxyline = require('galaxyline')
  local condition = require('galaxyline.condition')
  local fn = vim.fn
  local colorScheme = fn['enfocado#getColorScheme']()
  local colors = {
    bg_1 = colorScheme.bg_1[1],
    dim_0 = colorScheme.dim_0[1],
    red = colorScheme.red[1],
    green = colorScheme.green[1],
    yellow = colorScheme.yellow[1],
    blue = colorScheme.blue[1],
    cyan = colorScheme.cyan[1],
    br_red = colorScheme.br_red[1],
    br_yellow = colorScheme.br_yellow[1],
    br_blue = colorScheme.br_blue[1],
    br_orange = colorScheme.br_orange[1],
    accent = function()
      return fn.synIDattr(
        fn.synIDtrans(fn.hlID('Accent')), 'fg'
      )
    end
  }
  local section = galaxyline.section

  galaxyline.short_line_list = { 'fern', 'packer' }

  section.left[1] = {
    LeftIndicator = {
      provider = function()
        return '▊ '
      end,
      highlight = { colors.accent, colors.bg_1 }
    }
  }

  section.left[2] = {
    ViMode = {
      provider = function()
        local mode_color = {
          ['!'] = colors.cyan,
          [''] = colors.yellow,
          [''] = colors.green,
          ['r?'] = colors.red,
          c = colors.cyan,
          ce = colors.cyan,
          cv = colors.cyan,
          i = colors.green,
          ic = colors.green,
          n = colors.cyan,
          no = colors.cyan,
          r = colors.red,
          R = colors.red,
          rm = colors.red,
          Rv = colors.red,
          s = colors.green,
          S = colors.green,
          t = colors.cyan,
          v = colors.yellow,
          V = colors.yellow
        }

        vim.api.nvim_command(
          'highlight GalaxyViMode ' ..
          'guifg=' .. mode_color[vim.fn.mode()] .. ' guibg=' .. colors.bg_1
        )

        return ' '
      end,
      separator = ' ',
      separator_highlight = { 'NONE', colors.bg_1 }
    }
  }

  section.left[3] = {
    LineInfo = {
      provider = 'LineColumn',
      highlight = { colors.dim_0, colors.bg_1 }
    }
  }

  section.left[4] = {
    ModeSeparator = {
      provider = function()
        return ' '
      end,
      highlight = { 'NONE', colors.bg_1 }
    }
  }

  section.left[5] = {
    GitBranch = {
      provider = 'GitBranch',
      condition = condition.hide_in_width or condition.check_git_workspace,
      icon = ' ',
      highlight = { colors.dim_0, colors.bg_1 }
    }
  }

  section.left[6] = {
    HunksSeparator = {
      provider = function()
        return ' '
      end,
      highlight = { 'NONE', colors.bg_1 }
    }
  }

  section.left[7] = {
    DiffAdd = {
      provider = 'DiffAdd',
      condition = condition.hide_in_width,
      icon = '+',
      highlight = { colors.green, colors.bg_1 }
    }
  }

  section.left[8] = {
    DiffModified = {
      provider = 'DiffModified',
      condition = condition.hide_in_width,
      icon = '~',
      highlight = { colors.yellow, colors.bg_1 }
    }
  }

  section.left[9] = {
    DiffRemove = {
      provider = 'DiffRemove',
      condition = condition.hide_in_width,
      icon = '-',
      highlight = { colors.red, colors.bg_1 }
    }
  }

  section.left[10] = {
    DiagnosticSeparator = {
      provider = function()
        return ' '
      end,
      highlight = { 'NONE', colors.bg_1 },
    }
  }

  section.left[11] = {
    DiagnosticError = {
      provider = 'DiagnosticError',
      condition = condition.hide_in_width,
      icon = ' ',
      highlight = { colors.br_red, colors.bg_1, 'bold' }
    }
  }

  section.left[12] = {
    DiagnosticWarn = {
      provider = 'DiagnosticWarn',
      condition = condition.hide_in_width,
      icon = ' ',
      highlight = { colors.br_orange, colors.bg_1, 'bold' }
    }
  }

  section.left[13] = {
    DiagnosticInfo = {
      provider = 'DiagnosticInfo',
      condition = condition.hide_in_width,
      icon = ' ',
      highlight = { colors.br_yellow, colors.bg_1, 'bold' }
    }
  }

  section.left[14] = {
    DiagnosticHint = {
      provider = 'DiagnosticHint',
      condition = condition.hide_in_width,
      icon = ' ',
      highlight = { colors.br_blue, colors.bg_1, 'bold' }
    }
  }

  section.right[1] = {
    FileEncode = {
      provider = 'FileEncode',
      highlight = { colors.dim_0, colors.bg_1 }
    }
  }

  section.right[2] = {
    FileTypeName = {
      provider = 'FileTypeName',
      highlight = { colors.dim_0, colors.bg_1 },
      separator = ' ',
      separator_highlight = { 'NONE', colors.bg_1 }
    }
  }

  section.right[3] = {
    SleuthIndicator = {
      provider = function()
        return string.upper(fn.SleuthIndicator())
      end,
      highlight = { colors.dim_0, colors.bg_1 },
      separator = ' ',
      separator_highlight = { 'NONE', colors.bg_1 }
    }
  }

  section.right[4] = {
    FileFormat = {
      provider = 'FileFormat',
      highlight = { colors.dim_0, colors.bg_1 },
      separator = ' ',
      separator_highlight = { 'NONE', colors.bg_1 }
    }
  }

  section.right[5] = {
    RightSeparator = {
      provider = function()
        return ' '
      end,
      highlight = { 'NONE', colors.bg_1 }
    }
  }

  section.short_line_left[1] = {
    SLeftSeparator = {
      provider = function()
        return '▊ '
      end,
      highlight = { colors.dim_0, colors.bg_1 }
    }
  }

  section.short_line_left[2] = {
    SFileName = {
      provider = 'SFileName',
      condition = condition.buffer_not_empty,
      highlight = { colors.dim_0, colors.bg_1 }
    }
  }

  section.short_line_right[1] = {
    SFileTypeName = {
      provider = 'FileTypeName',
      highlight = { colors.dim_0, colors.bg_1 }
    }
  }

  section.short_line_right[2] = {
    SRightSeparator = {
      provider = function()
        return ' '
      end,
      highlight = { 'NONE', colors.bg_1 }
    }
  }

end

return M

