vim.g.loaded_2html_plugin = 1
vim.g.loaded_cfilter = 1
vim.g.loaded_gzip = 1
vim.g.loaded_man = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_msgpack_autoload = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwFileHandlers = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_node_provider = 1
vim.g.loaded_perl_provider = 1
vim.g.loaded_python3_provider = 1
vim.g.loaded_pythonx_provider = 1
vim.g.loaded_remote_plugins = 1
vim.g.loaded_ruby_provider = 1
vim.g.loaded_shada_autoload = 1
vim.g.loaded_shada_plugin = 1
vim.g.loaded_spellfile_plugin = 1
vim.g.loaded_sql_completion = 1
vim.g.loaded_syntax_completion = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1

local executable = vim.fn.executable

if executable("fzf") == 1 and executable("fd") == 1 then
  vim.env.FZF_DEFAULT_COMMAND = 'fd -I -H -E "{'
    .. ".git,.svn,.hg,CSV,.DS_Store,Thumbs.db,"
    .. "node_modules,bower_components,*.code-search"
    .. '}" -t f'
end

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

function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or "rounded"

  return ref_floating_preview(contents, syntax, opts, ...)
end
