local M = {}

M.setup = function()
  local columns = vim.opt.columns:get()

  vim.g["fern#disable_default_mappings"] = 1
  vim.g["fern#default_hidden"] = 1
  vim.g["fern#default_exclude"] =
    [[^\%(\.git\|\.svn\|\.hg\|\CVS\|\.DS_Store\|\Thumbs.db\)$]]
  vim.g["fern#drawer_width"] =
    math.floor((columns / (columns >= 160 and 3 or 2)) / 2)
  vim.g["fern#disable_drawer_hover_popup"] = 1
  vim.g["fern#drawer_hover_popup_delay"] = 40
  vim.g["fern_git_status#disable_ignored"] = 1
  vim.g["fern_git_status#disable_untracked"] = 1
  vim.g["fern#renderer"] = "nerdfont"
  vim.g["fern#renderer#nerdfont#root_symbol"] = ""
  vim.g["fern#renderer#nerdfont#indent_markers"] = 1
end

M.config = function()
  local keymap_set = vim.keymap.set
  local keymap_opts = { nowait = true, buffer = true }
  local keymap_opts_with_expr =
  { nowait = true, buffer = true, expr = true }

  local open_or_collapse = function()
    return vim.fn["fern#smart#leaf"](
      "<Plug>(fern-action-open)",
      "<Plug>(fern-action-expand)",
      "<Plug>(fern-action-collapse)"
    )
  end

  vim.api.nvim_create_autocmd("FileType", {
    pattern = "fern",
    callback = function()
      vim.fn["glyph_palette#apply"]()

      vim.opt_local.number = false
      vim.opt_local.relativenumber = false

      keymap_set(
        "n",
        "<",
        "<Plug>(fern-action-leave)"
          .. "<Plug>(fern-wait)"
          .. "<Plug>(fern-action-cd:root)"
          .. "<Cmd>echomsg getcwd()<CR>",
        keymap_opts
      )
      keymap_set(
        "n",
        ">",
        "<Plug>(fern-action-enter)"
          .. "<Plug>(fern-wait)"
          .. "<Plug>(fern-action-cd:root)"
          .. "<Cmd>echomsg getcwd()<CR>",
        keymap_opts
      )
      keymap_set("n", "h", "<Plug>(fern-action-collapse)", keymap_opts)
      keymap_set("n", "l", "<Plug>(fern-action-expand)", keymap_opts)
      keymap_set("n", "o", open_or_collapse, keymap_opts_with_expr)
      keymap_set("n", "<2-LeftMouse>", open_or_collapse, keymap_opts_with_expr)
      keymap_set("n", "<CR>", "<Plug>(fern-action-open-or-expand)", keymap_opts)
      keymap_set("n", "<BS>", "<Plug>(fern-action-collapse)", keymap_opts)
      keymap_set("n", "<C-T>", "<Plug>(fern-action-open:tabedit)", keymap_opts)
      keymap_set("n", "<C-s>", "<Plug>(fern-action-open:split)", keymap_opts)
      keymap_set("n", "<C-v>", function()
        return vim.fn["fern#smart#drawer"](
          "<Plug>(fern-action-open:rightest)",
          "<Plug>(fern-action-open:vsplit)",
          "<Plug>(fern-action-open:vsplit)"
        )
      end, keymap_opts_with_expr)
      keymap_set("n", "n", "<Plug>(fern-action-new-path)", { buffer = true })
      keymap_set("n", "nf", "<Plug>(fern-action-new-file)", keymap_opts)
      keymap_set("n", "nd", "<Plug>(fern-action-new-dir)", keymap_opts)
      keymap_set("n", "m", "<Plug>(fern-action-move)", keymap_opts)
      keymap_set("n", "c", "<Plug>(fern-action-copy)", keymap_opts)
      keymap_set("n", "d", "<Plug>(fern-action-remove)", keymap_opts)
      keymap_set("n", "q", "<Cmd>quit<CR>", keymap_opts)
      keymap_set("n", "<F5>", "<Plug>(fern-action-reload)", keymap_opts)
      keymap_set("n", "g?", "<Plug>(fern-action-help)", keymap_opts)
      keymap_set("n", "?", "<Plug>(fern-action-help)", keymap_opts)
    end,
  })

  keymap_set("n", "<leader>ft", "<Cmd>Fern . -reveal=% -drawer -toggle<CR>")
end

return M
