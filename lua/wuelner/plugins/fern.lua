return {
  "lambdalisue/fern.vim",
  lazy = false,
  dependencies = {
    "lambdalisue/fern-hijack.vim",
    {
      "lambdalisue/fern-renderer-nerdfont.vim",
      dependencies = { "lambdalisue/nerdfont.vim", "lambdalisue/glyph-palette.vim" },
      init = function()
        vim.api.nvim_set_var("fern#renderer", "nerdfont")
        vim.api.nvim_set_var("fern#renderer#nerdfont#root_symbol", "")
        vim.api.nvim_set_var("fern#renderer#nerdfont#root_leading", "")
        vim.api.nvim_set_var("fern#renderer#nerdfont#indent_markers", 1)
      end,
    },
    {
      "lambdalisue/fern-git-status.vim",
      init = function()
        vim.api.nvim_set_var("fern_git_status#disable_ignored", 1)
        vim.api.nvim_set_var("fern_git_status#disable_untracked", 1)
      end,
    },
  },
  init = function()
    local columns = vim.api.nvim_get_option_value("columns", {})

    vim.api.nvim_set_var("fern#default_hidden", 1)
    vim.api.nvim_set_var("fern#default_exclude", [[^\%(\.git\|\.svn\|\.hg\|\CVS\|\.DS_Store\|\Thumbs.db\)$]])
    vim.api.nvim_set_var("fern#disable_default_mappings", 1)
    vim.api.nvim_set_var("fern#disable_drawer_hover_popup", 1)
    vim.api.nvim_set_var("fern#drawer_width", math.floor((columns / (columns >= 160 and 3 or 2)) / 2))
    vim.api.nvim_set_var("fern#drawer_hover_popup_delay", 40)
    vim.api.nvim_set_var("fern#mark_symbol", "")
  end,
  config = function()
    vim.api.nvim_set_keymap("n", "<leader>ft", "", {
      callback = function()
        vim.api.nvim_command("Fern . -reveal=% -drawer -toggle")
      end,
    })
  end,
}
