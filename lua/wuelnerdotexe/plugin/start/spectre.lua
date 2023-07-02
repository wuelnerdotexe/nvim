return {
  {
    "nvim-pack/nvim-spectre",
    dependencies = "nvim-lua/plenary.nvim",
    keys = {
      {
        "<leader>wr",
        "<Cmd>lua require('spectre').open()<CR>",
        desc = "General: [r]eplace [w]ord in the current directory",
      },
      {
        "<leader>wr",
        "<Esc><Cmd>lua require('spectre').open_visual()<CR>",
        desc = "General: [r]eplace [w]ord in the current directory",
        mode = "x",
      },
    },
    cmd = "Spectre",
    init = function() table.insert(require("wuelnerdotexe.plugin.util").user_interface_filetypes, "spectre_panel") end,
    config = function()
      require("spectre").setup({
        open_cmd = "new",
        live_update = true,
        line_sep_start = "╭───────────────────────────────────────────────────────────────────────────────",
        result_padding = "│ ",
        line_sep = "╰───────────────────────────────────────────────────────────────────────────────",
        highlight = {
          border = "LpsSignatureActiveParameter",
          ui = "LspCodeLens",
          headers = "Title",
          filedirectory = "Directory",
          filename = "diffFile",
          search = "diffRemoved",
          replace = "diffAdded",
        },
        mapping = {
          toggle_line = {
            map = "<localleader>lt",
            cmd = "<cmd>lua require('spectre').toggle_line()<CR>",
            desc = "toggle current item",
          },
          enter_file = {
            map = "<localleader>fo",
            cmd = "<cmd>lua require('spectre.actions').select_entry()<CR>",
            desc = "goto current file",
          },
          send_to_qf = {
            map = "<localleader>sq",
            cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
            desc = "send all item to quickfix",
          },
          replace_cmd = {
            map = "<localleader>ri",
            cmd = "<cmd>lua require('spectre.actions').replace_cmd()<CR>",
            desc = "input replace vim command",
          },
          show_option_menu = {
            map = "<localleader>os",
            cmd = "<cmd>lua require('spectre').show_options()<CR>",
            desc = "show option",
          },
          run_current_replace = {
            map = "<localleader>rc",
            cmd = "<cmd>lua require('spectre.actions').run_current_replace()<CR>",
            desc = "replace current line",
          },
          run_replace = {
            map = "<localleader>rr",
            cmd = "<cmd>lua require('spectre.actions').run_replace()<CR>",
            desc = "replace all",
          },
          change_view_mode = {
            map = "<localleader>vc",
            cmd = "<cmd>lua require('spectre').change_view()<CR>",
            desc = "change result view mode",
          },
          change_replace_sed = {
            map = "<localleader>sr",
            cmd = "<cmd>lua require('spectre').change_engine_replace('sed')<CR>",
            desc = "use sed to replace",
          },
          change_replace_oxi = {
            map = "<localleader>or",
            cmd = "<cmd>lua require('spectre').change_engine_replace('oxi')<CR>",
            desc = "use oxi to replace",
          },
          toggle_live_update = {
            map = "<localleader>lt",
            cmd = "<cmd>lua require('spectre').toggle_live_update()<CR>",
            desc = "update change when vim write file.",
          },
          toggle_ignore_case = {
            map = "<localleader>it",
            cmd = "<cmd>lua require('spectre').change_options('ignore-case')<CR>",
            desc = "toggle ignore case",
          },
          toggle_ignore_hidden = {
            map = "<localleader>ht",
            cmd = "<cmd>lua require('spectre').change_options('hidden')<CR>",
            desc = "toggle search hidden",
          },
          resume_last_search = {
            map = "<localleader>sr",
            cmd = "<cmd>lua require('spectre').resume_last_search()<CR>",
            desc = "resume last search before close",
          },
        },
        find_engine = {
          ["rg"] = {
            args = { "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--trim" },
          },
        },
        default = { find = { options = { "ignore-case", "hidden" } }, replace = { options = { "ignore-case" } } },
        is_insert_mode = true,
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "spectre_panel",
        callback = function(ev) vim.api.nvim_set_option_value("number", false, { buf = ev.buf }) end,
      })
    end,
  },
  {
    "folke/edgy.nvim",
    optional = true,
    ft = "spectre_panel",
    opts = function(_, opts)
      opts.bottom = vim.list_extend(opts.bottom or {}, {
        { ft = "spectre_panel", title = "Spectre", size = { height = 0.5 } },
      })
    end,
  },
}
