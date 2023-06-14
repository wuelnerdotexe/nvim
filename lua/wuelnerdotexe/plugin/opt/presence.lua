return {
  "andweeb/presence.nvim",
  event = "BufEnter",
  config = function()
    require("presence"):setup({
      neovim_image_text = "El editor de código más cool del mundo mundial",
      debounce_timeout = 284,
      editing_text = "Buggeando %s",
      file_explorer_text = "Navegando con %s",
      git_commit_text = "Comiteando bugs",
      plugin_manager_text = "Administrando plugins",
      reading_text = "Leyendo %s",
      workspace_text = "Trabajando en %s",
      line_number_text = "Linea %s de %s",
    })
  end,
}
