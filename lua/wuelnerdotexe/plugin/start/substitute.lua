return {
  "gbprod/substitute.nvim",
  keys = {
    { "s", function() require("substitute").operator() end },
    { "ss", function() require("substitute").line() end },
    { "S", function() require("substitute").eol() end },
    { "s", function() require("substitute").visual() end, mode = "x" },
    { "sx", function() require("substitute.exchange").operator() end },
    { "sxx", function() require("substitute.exchange").line() end },
    { "X", function() require("substitute.exchange").visual() end, mode = "x" },
  },
  init = function()
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = function() vim.api.nvim_command("highlight! link SubstituteSubstituted TextYanked") end,
    })
  end,
  opts = { yank_substituted_text = true, highlight_substituted_text = { timer = 125 } },
  config = function(_, opts)
    local yanky_status, yanky_integration = pcall(require, "yanky.integration")

    if yanky_integration_status then opts.on_substitute = yanky_integration.substitute() end

    require("substitute").setup(opts)
  end,
}
