local M = {}

M.setup = function()
  local vim_g = vim.g

  vim_g.sleuth_aerial_heuristics = 0
  vim_g.sleuth_checkhealth_heuristics = 0
  vim_g.sleuth_dapui_breakpoints_heuristics = 0
  vim_g.sleuth_dapui_console_heuristics = 0
  vim_g.sleuth_dapui_hover_heuristics = 0
  vim_g.sleuth_dapui_scopes_heuristics = 0
  vim_g.sleuth_dapui_stacks_heuristics = 0
  vim_g.sleuth_dapui_watches_heuristics = 0
  vim_g.sleuth_fern_heuristics = 0
  vim_g.sleuth_list_heuristics = 0
  vim_g.sleuth_lspinfo_heuristics = 0
  vim_g.sleuth_mason_heuristics = 0
  vim_g.sleuth_nerdterm_heuristics = 0
  vim_g.sleuth_packer_heuristics = 0
  vim_g.sleuth_qf_heuristics = 0
  vim_g.sleuth_TelescopePrompt_heuristics = 0
end

return M
