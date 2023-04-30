-- Disable {Neo}Vim native plugins.
vim.api.nvim_set_var("loaded_2html_plugin", 1)
vim.api.nvim_set_var("loaded_gzip", 1)
vim.api.nvim_set_var("loaded_man", 1)
vim.api.nvim_set_var("loaded_shada_autoload", 1)
vim.api.nvim_set_var("loaded_shada_plugin", 1)
vim.api.nvim_set_var("loaded_sql_completion", 1)
vim.api.nvim_set_var("loaded_tar", 1)
vim.api.nvim_set_var("loaded_tarPlugin", 1)
vim.api.nvim_set_var("loaded_tutor_mode_plugin", 1)
vim.api.nvim_set_var("loaded_zip", 1)
vim.api.nvim_set_var("loaded_zipPlugin", 1)

-- Disable Neovim plugin providers.
vim.api.nvim_set_var("loaded_node_provider", 0)
vim.api.nvim_set_var("loaded_ruby_provider", 0)
vim.api.nvim_set_var("loaded_perl_provider", 0)

-- Uninstall {Neo}Vim native menus.
vim.api.nvim_set_var("did_install_default_menus", 1)
vim.api.nvim_set_var("did_install_syntax_menu", 1)
