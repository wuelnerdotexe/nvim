return {
  "andweeb/presence.nvim",
  event = require("wuelnerdotexe.utils").plugins.open_file_event,
  config = function()
    require("presence"):setup({
      neovim_image_text = "El editor de código más cool del mundo mundial",
      debounce_timeout = 284,
      editing_text = "Escribiendo bugs en %s",
      file_explorer_text = "Siendo un ninja con %s",
      git_commit_text = "Comiteando bugs directo a producción",
      plugin_manager_text = "Procrastinando con Neovim",
      reading_text = "Buscando bugs en %s",
      workspace_text = "Supuestamente trabajando en %s",
      line_number_text = "Linea %s de %s",
    })
  end,
}
