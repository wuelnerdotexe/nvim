local M = {}

M.config = function()
  require("cmp_tabnine.config").setup({
    ignored_file_types = {
      ["aerial"] = true,
      ["checkhealth"] = true,
      ["fern"] = true,
      ["fugitive"] = true,
      ["fugitiveblame"] = true,
      ["lspinfo"] = true,
      ["mason"] = true,
      ["nerdterm"] = true,
      ["null-ls-info"] = true,
      ["packer"] = true,
      ["qf"] = true,
      ["TelescopePrompt"] = true,
    },
  })
end

return M
