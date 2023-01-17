require("projections").setup({
  workspaces = { { "~/Workspace", {} } },
  patterns = { ".git" },
  store_hooks = {
    pre = function()
      vim.api.nvim_command("FernDo close")
    end,
  },
})

local create_autocmd = vim.api.nvim_create_autocmd
local cwd = vim.loop.cwd

create_autocmd("VimLeavePre", {
  callback = function()
    require("projections.session").store(cwd())

    return true
  end,
  once = true,
})

create_autocmd("VimEnter", {
  callback = function()
    if vim.api.nvim_call_function("argc", {}) == 0 then
      require("projections.switcher").switch(cwd())
    end

    return true
  end,
  once = true,
})
