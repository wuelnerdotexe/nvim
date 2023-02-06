return {
  "folke/noice.nvim",
  enabled = vim.version().minor >= 9,
  cond = vim.api.nvim_call_function("exists", { "g:neovide" }) ~= 1,
  event = "UIEnter",
  dependencies = "MunifTanjim/nui.nvim",
  config = function()
    local option_opts = {}

    vim.api.nvim_set_option_value("cmdheight", 0, option_opts)
    vim.api.nvim_set_option_value("showcmd", false, option_opts)
    vim.api.nvim_set_option_value("showmode", false, option_opts)
    vim.api.nvim_set_option_value(
      "shortmess",
      vim.api.nvim_get_option_value("shortmess", option_opts) .. "Wc",
      option_opts
    )

    require("noice").setup({
      cmdline = { view = "cmdline" },
      popupmenu = { enabled = false },
      lsp = {
        progress = { enabled = false },
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = { bottom_search = true, long_message_to_split = true, lsp_doc_border = true },
      throttle = 40,
      views = {
        split = {
          size = "25%",
          win_options = { signcolumn = "no", number = false, relativenumber = false, list = false, wrap = false },
        },
      },
    })

    local keymap_callback_scroll_backward = {
      callback = function()
        if not require("noice.lsp").scroll(-1) then
          return "<C-b>"
        end
      end,
      expr = true,
      replace_keycodes = true,
    }

    vim.api.nvim_set_keymap("n", "<C-b>", "", keymap_callback_scroll_backward)
    vim.api.nvim_set_keymap("i", "<C-b>", "", keymap_callback_scroll_backward)
    vim.api.nvim_set_keymap("s", "<C-b>", "", keymap_callback_scroll_backward)

    local keymap_callback_scroll_forward = {
      callback = function()
        if not require("noice.lsp").scroll(1) then
          return "<C-f>"
        end
      end,
      expr = true,
      replace_keycodes = true,
    }

    vim.api.nvim_set_keymap("n", "<C-f>", "", keymap_callback_scroll_forward)
    vim.api.nvim_set_keymap("i", "<C-f>", "", keymap_callback_scroll_forward)
    vim.api.nvim_set_keymap("s", "<C-f>", "", keymap_callback_scroll_forward)
  end,
}
