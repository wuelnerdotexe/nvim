return {
  "junegunn/fzf",
  build = function() vim.api.nvim_call_function("fzf#install", TBL) end,
  keys = { { "<C-p>", function() vim.api.nvim_command([[FZF --border-label=\ Search\ Files\ by\ Name\ ]]) end } },
  cmd = "FZF",
  init = function()
    require("wuelnerdotexe.plugin.util").set_option("guicursor", "a:block")

    if os.getenv("TMUX") then vim.api.nvim_set_var("fzf_layout", { tmux = "-p90%,60%" }) end

    vim.api.nvim_call_function("setenv", {
      "FZF_DEFAULT_OPTS",
      "-i --cycle --reverse --info=right --scrollbar=' ' --pointer=' ' --marker=' '",
    })

    if vim.api.nvim_call_function("executable", { "fd" }) == 1 then
      vim.api.nvim_call_function("setenv", {
        "FZF_DEFAULT_COMMAND",
        "fd -I -H -E '{"
          .. table.concat(require("wuelnerdotexe.plugin.config").exclude_search_files, ",")
          .. "}' -t f --color never",
      })
    end

    vim.api.nvim_set_var("fzf_action", { ["ctrl-t"] = "tab split", ["ctrl-s"] = "split", ["ctrl-v"] = "vsplit" })
  end,
}
