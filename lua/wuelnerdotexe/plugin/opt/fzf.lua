return {
  "junegunn/fzf",
  build = function() vim.api.nvim_call_function("fzf#install", {}) end,
  keys = { { "<C-p>", function() vim.api.nvim_command([[FZF --border-label=\ Search\ Files\ by\ Name\ ]]) end } },
  cmd = "FZF",
  init = function()
    require("wuelnerdotexe.plugin.util").add_colorscheme_integration("fzf")

    require("wuelnerdotexe.plugin.util").set_option("guicursor", "a:block")

    table.insert(require("wuelnerdotexe.plugin.util").user_interface_filetypes, "fzf")

    if os.getenv("TMUX") then vim.api.nvim_set_var("fzf_layout", { tmux = "-p90%,60%" }) end

    vim.api.nvim_call_function("setenv", {
      "FZF_DEFAULT_OPTS",
      "-i --cycle --reverse --info=right --scrollbar=' ' --pointer=' ' --marker=' '",
    })

    if vim.api.nvim_call_function("executable", { "fd" }) == 1 then
      vim.api.nvim_call_function("setenv", {
        "FZF_DEFAULT_COMMAND",
        "fd -I -H -E '{.git,.svn,.hg,CSV,.DS_Store,thumbs.db,node_modules,bower_components,*.code-search}' -t f --color never",
      })
    end

    vim.api.nvim_set_var("fzf_action", { ["ctrl-t"] = "tab split", ["ctrl-s"] = "split", ["ctrl-v"] = "vsplit" })
  end,
}
