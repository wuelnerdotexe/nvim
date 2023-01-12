require("projections").setup({ workspaces = { { "~/Workspace", {} } }, patterns = { ".git" } })

local create_autocmd, cwd = vim.api.nvim_create_autocmd, vim.loop.cwd

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

      return true
    end

    return true
  end,
  once = true,
})
