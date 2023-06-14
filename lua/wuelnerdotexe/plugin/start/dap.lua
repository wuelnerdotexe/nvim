return {
  "mfussenegger/nvim-dap",
  dependencies = {
    {
      "jay-babu/mason-nvim-dap.nvim",
      dependencies = "williamboman/mason.nvim",
      cmd = { "MasonInstall", "MasonUninstall" },
      config = function() require("mason-nvim-dap").setup({ ensure_installed = { "firefox", "node2" } }) end,
    },
    {
      "rcarriga/nvim-dap-ui",
      config = function()
        require("dapui").setup({
          layouts = {
            {
              elements = { "scopes", "watches", "stacks", "breakpoints" },
              size = require("wuelnerdotexe.plugin.util").get_sidebar_width(),
              position = "left",
            },
            { elements = { "console", "repl" }, size = 0.25, position = "bottom" },
          },
        })
      end,
    },
  },
  keys = {
    { "<F9>", function() require("dap").toggle_breakpoint() end },
    { "<F5>", function() require("dap").continue() end },
  },
  cmd = {
    "DapContinue",
    "DapLoadLaunchJSON",
    "DapRestartFrame",
    "DapSetLogLevel",
    "DapShowLog",
    "DapStepInto",
    "DapStepOut",
    "DapStepOver",
    "DapTerminate",
    "DapToggleBreakpoint",
    "DapToggleRepl",
  },
  config = function()
    vim.api.nvim_call_function(
      "sign_define",
      { "DapBreakpoint", { linehl = "", text = "", texthl = "GitSignsDelete", numhl = "" } }
    )

    vim.api.nvim_call_function(
      "sign_define",
      { "DapBreakpointCondition", { linehl = "", text = "", texthl = "GitSignsDelete", numhl = "" } }
    )

    vim.api.nvim_call_function(
      "sign_define",
      { "DapLogPoint", { linehl = "", text = "", texthl = "GitSignsDelete", numhl = "" } }
    )

    vim.api.nvim_call_function(
      "sign_define",
      { "DapStopped", { linehl = "GitSignsChangeLn", text = "", texthl = "GitSignsChange", numhl = "" } }
    )

    vim.api.nvim_call_function(
      "sign_define",
      { "DapBreakpointRejected", { linehl = "", text = "", texthl = "", numhl = "" } }
    )

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

    for _, language in pairs({ "javascript", "typescript" }) do
      require("dap").configurations[language] = {
        {
          name = "Launch Node against current file",
          type = "node2",
          request = "launch",
          program = "${file}",
          cwd = vim.loop.cwd(),
          sourceMaps = true,
          protocol = "inspector",
          console = "integratedTerminal",
        },
        {
          name = "Launch Node against pick process",
          type = "node2",
          request = "attach",
          processId = require("dap.utils").pick_process,
          console = "integratedTerminal",
        },
        {
          name = "Launch Firefox against localhost",
          request = "launch",
          type = "firefox",
          reAttach = true,
          url = "http://localhost:3000",
          webRoot = "${workspaceFolder}",
          console = "integratedTerminal",
        },
      }
    end

    for _, language in pairs({ "javascriptreact", "typescriptreact" }) do
      require("dap").configurations[language] = {
        {
          name = "Launch Firefox against localhost",
          request = "launch",
          type = "firefox",
          reAttach = true,
          url = "http://localhost:3000",
          webRoot = "${workspaceFolder}",
          console = "integratedTerminal",
        },
      }
    end

    require("dap").listeners.after.event_initialized.dapui_config = function()
      require("dapui").open()

      vim.api.nvim_set_keymap("n", "<F6>", "", { callback = function() require("dap").pause() end })
      vim.api.nvim_set_keymap("n", "<F10>", "", { callback = function() require("dap").step_over() end })
      vim.api.nvim_set_keymap("n", "<F11>", "", { callback = function() require("dap").step_into() end })
      vim.api.nvim_set_keymap("n", "<F17>", "", { callback = function() require("dap").terminate() end })
      vim.api.nvim_set_keymap("n", "<F41>", "", { callback = function() require("dap").run_last() end })
      vim.api.nvim_set_keymap("n", "<F23>", "", { callback = function() require("dap").step_out() end })
      vim.api.nvim_set_keymap("n", "<F35>", "", {
        callback = function() require("dap").step_into({ ask_for_targets = true }) end,
      })
    end

    require("dap").listeners.before.event_exited.dapui_config = function()
      require("dapui").close()

      vim.api.nvim_del_keymap("n", "<F6>")
      vim.api.nvim_del_keymap("n", "<F10>")
      vim.api.nvim_del_keymap("n", "<F11>")
      vim.api.nvim_del_keymap("n", "<F17>") -- S-F5
      vim.api.nvim_del_keymap("n", "<F41>") -- S-C-F5
      vim.api.nvim_del_keymap("n", "<F23>") -- S-F11
      vim.api.nvim_del_keymap("n", "<F35>") -- C-F11
    end

    require("dap").listeners.before.event_terminated.dapui_config = function()
      require("dapui").close()

      vim.api.nvim_del_keymap("n", "<F6>")
      vim.api.nvim_del_keymap("n", "<F10>")
      vim.api.nvim_del_keymap("n", "<F11>")
      vim.api.nvim_del_keymap("n", "<F17>") -- S-F5
      vim.api.nvim_del_keymap("n", "<F41>") -- S-C-F5
      vim.api.nvim_del_keymap("n", "<F23>") -- S-F11
      vim.api.nvim_del_keymap("n", "<F35>") -- C-F11
    end
  end,
}
