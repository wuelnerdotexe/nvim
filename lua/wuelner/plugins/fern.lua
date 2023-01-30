return {
  "lambdalisue/fern.vim",
  lazy = false,
  dependencies = {
    "lambdalisue/fern-hijack.vim",
    {
      "lambdalisue/fern-renderer-nerdfont.vim",
      dependencies = { "lambdalisue/nerdfont.vim", "lambdalisue/glyph-palette.vim" },
      init = function()
        local set_var = vim.api.nvim_set_var

        set_var("fern#renderer", "nerdfont")
        set_var("fern#renderer#nerdfont#root_symbol", "")
        set_var("fern#renderer#nerdfont#root_leading", "")
        set_var("fern#renderer#nerdfont#indent_markers", 1)
      end,
    },
    {
      "lambdalisue/fern-git-status.vim",
      init = function()
        local set_var = vim.api.nvim_set_var

        set_var("fern_git_status#disable_ignored", 1)
        set_var("fern_git_status#disable_untracked", 1)
      end,
    },
  },
  init = function()
    local set_var = vim.api.nvim_set_var
    local columns = vim.api.nvim_get_option_value("columns", {})

    set_var("fern#default_hidden", 1)
    set_var("fern#default_exclude", [[^\%(\.git\|\.svn\|\.hg\|\CVS\|\.DS_Store\|\Thumbs.db\)$]])
    set_var("fern#disable_default_mappings", 1)
    set_var("fern#disable_drawer_hover_popup", 1)
    set_var("fern#drawer_width", math.floor((columns / (columns >= 160 and 3 or 2)) / 2))
    set_var("fern#drawer_hover_popup_delay", 40)
    set_var("fern#mark_symbol", "")
  end,
  config = function()
    local command = vim.api.nvim_command

    vim.api.nvim_set_keymap("n", "<leader>ft", "", {
      callback = function()
        command("Fern . -reveal=% -drawer -toggle")
      end,
    })
  end,
}
