local config = function()
  require("dap").adapters.node2 = {
    type = "executable",
    command = "node",
    args = {
      require("mason-registry").get_package("node-debug2-adapter"):get_install_path() .. "/out/src/nodeDebug.js",
    },
  }

  require("dap").adapters.firefox = {
    type = "executable",
    command = "node",
    args = {
      require("mason-registry").get_package("firefox-debug-adapter"):get_install_path() .. "/dist/adapter.bundle.js",
    },
  }

  for _, language in ipairs({ "javascript", "javascriptreact", "typescript", "typescriptreact" }) do
    require("dap").configurations[language] = {
      {
        name = "Launch Node against current file",
        type = "node2",
        request = "launch",
        program = "${file}",
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
        console = "integratedTerminal",
      },
      {
        name = "Launch Firefox against localhost",
        request = "launch",
        type = "firefox",
        reAttach = true,
        url = "http://localhost:8080",
        webRoot = "${workspaceFolder}",
        console = "integratedTerminal",
      },
    }
  end

  require("mason-nvim-dap").setup({ ensure_installed = { "firefox", "node2" } })

  local sign_define = vim.fn.sign_define

  sign_define("DapBreakpoint", { linehl = "", text = "", texthl = "GitSignsDelete", numhl = "" })
  sign_define("DapBreakpointCondition", { linehl = "", text = "", texthl = "GitSignsDelete", numhl = "" })
  sign_define("DapLogPoint", { linehl = "", text = "", texthl = "GitSignsDelete", numhl = "" })
  sign_define("DapStopped", { linehl = "GitSignsChangeLn", text = "", texthl = "GitSignsChange", numhl = "" })
  sign_define("DapBreakpointRejected", { linehl = "", text = "", texthl = "", numhl = "" })

  local keymap_set = vim.keymap.set

  keymap_set("n", "<F5>", require("dap").continue)
  keymap_set("n", "<F9>", require("dap").toggle_breakpoint)

  local columns = vim.opt.columns:get()

  require("dapui").setup({
    layouts = {
      {
        elements = { "scopes", "watches", "stacks", "breakpoints" },
        size = math.floor((columns / (columns >= 160 and 3 or 2)) / 2),
        position = "left",
      },
      { elements = { "console", "repl" }, size = 0.25, position = "bottom" },
    },
  })

  local dapui_close = require("dapui").close
  local repl_close = require("dap").repl.close

  require("dap").listeners.after.event_initialized["dapui_config"] = function()
    keymap_set("n", "<F6>", require("dap").pause)
    keymap_set("n", "<F10>", require("dap").step_over)

    local step_into = require("dap").step_into

    keymap_set("n", "<F11>", step_into)

    local step_into_targets = function()
      step_into({ ask_for_targets = true })
    end

    keymap_set("n", "<C-F11>", step_into_targets)
    keymap_set("n", "<F35>", step_into_targets)

    local step_out = require("dap").step_out

    keymap_set("n", "<S-F11>", step_out)
    keymap_set("n", "<F23>", step_out)

    local run_last = require("dap").run_last

    keymap_set("n", "<C-S-F5>", run_last)
    keymap_set("n", "<F41>", run_last)

    local dap_terminate = function()
      require("dap").terminate(); dapui_close(); repl_close()
    end

    keymap_set("n", "<S-F5>", dap_terminate)
    keymap_set("n", "<F17>", dap_terminate)

    require("dapui").open()
  end

  local keymaps_del = function()
    local keymap_del = vim.keymap.del

    keymap_del("n", "<F6>")
    keymap_del("n", "<F10>")
    keymap_del("n", "<F11>")
    keymap_del("n", "<C-F11>")
    keymap_del("n", "<F35>")
    keymap_del("n", "<S-F11>")
    keymap_del("n", "<F23>")
    keymap_del("n", "<C-S-F5>")
    keymap_del("n", "<F41>")
    keymap_del("n", "<S-F5>")
    keymap_del("n", "<F17>")
  end

  require("dap").listeners.before.event_exited["dapui_config"] = function()
    dapui_close()
    repl_close()
    keymaps_del()
  end

  require("dap").listeners.before.event_terminated["dapui_config"] = function()
    dapui_close()
    repl_close()
    keymaps_del()
  end
end

return config
