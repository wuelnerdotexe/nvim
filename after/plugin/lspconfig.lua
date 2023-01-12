vim.diagnostic.config({
  signs = { priority = 9 },
  virtual_text = false, -- { prefix = "▎" },
  virtual_lines = true,
  float = { header = { "Diagnostics", "Title" }, border = "rounded" },
  update_in_insert = true,
  severity_sort = true,
})

local ref_floating_preview = vim.lsp.util.open_floating_preview

vim.lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = "rounded"

  return ref_floating_preview(contents, syntax, opts, ...)
end
