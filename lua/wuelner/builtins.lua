local set_var = vim.api.nvim_set_var

set_var("loaded_2html_plugin", 1)
set_var("loaded_cfilter", 1)
set_var("loaded_gzip", 1)
set_var("loaded_man", 1)
set_var("loaded_matchit", 1)
set_var("loaded_matchparen", 1)
set_var("loaded_msgpack_autoload", 1)
set_var("loaded_netrw", 1)
set_var("loaded_netrwFileHandlers", 1)
set_var("loaded_netrwPlugin", 1)
set_var("loaded_netrwSettings", 1)
set_var("loaded_node_provider", 1)
set_var("loaded_perl_provider", 1)
set_var("loaded_python3_provider", 1)
set_var("loaded_pythonx_provider", 1)
set_var("loaded_remote_plugins", 1)
set_var("loaded_ruby_provider", 1)
set_var("loaded_shada_autoload", 1)
set_var("loaded_shada_plugin", 1)
set_var("loaded_spellfile_plugin", 1)
set_var("loaded_sql_completion", 1)
set_var("loaded_syntax_completion", 1)
set_var("loaded_tar", 1)
set_var("loaded_tarPlugin", 1)
set_var("loaded_tutor_mode_plugin", 1)
set_var("loaded_vimball", 1)
set_var("loaded_vimballPlugin", 1)
set_var("loaded_zip", 1)
set_var("loaded_zipPlugin", 1)

vim.diagnostic.config({
  signs = { priority = 9 },
  virtual_text = { prefix = "▎" },
  float = {
    header = { "Diagnostics", "Title" },
    border = "rounded",
  },
  update_in_insert = true,
  severity_sort = true,
})

local ref_floating_preview = vim.lsp.util.open_floating_preview

vim.lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = "rounded"

  return ref_floating_preview(contents, syntax, opts, ...)
end
