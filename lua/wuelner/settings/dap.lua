local M = {}

M.config = function()
  local dap = require("dap")
  local get_package = require("mason-registry").get_package

  dap.adapters.chrome = {
    type = "executable",
    command = "node",
    args = {
      get_package("chrome-debug-adapter"):get_install_path()
        .. "/out/src/chromeDebug.js"
    },
  }

  dap.adapters.firefox = {
    type = "executable",
    command = "node",
    args = {
      get_package("firefox-debug-adapter"):get_install_path()
        .. "/dist/adapter.bundle.js"
    },
  }

  for _, language in ipairs({
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
  }) do
    dap.configurations[language] = {
      {
        type = "chrome",
        request = "launch",
        name = 'Launch Chrome against localhost',
        url = 'http://localhost:5173',
        webRoot = "${workspaceFolder}"
      },
      {
        type = 'firefox',
        request = 'launch',
        reAttach = true,
        name = 'Launch Firefox against localhost',
        url = 'http://localhost:5173',
        webRoot = '${workspaceFolder}',
      }
    }
  end

  local sign_define = vim.fn.sign_define

  sign_define("DapBreakpoint", {
    linehl = "",
    text = "",
    texthl = "GitSignsDelete",
    numhl = "",
  })
  sign_define("DapBreakpointCondition", {
    linehl = "",
    text = "",
    texthl = "GitSignsDelete",
    numhl = "",
  })
  sign_define("DapLogPoint", {
    linehl = "",
    text = "",
    texthl = "GitSignsDelete",
    numhl = "",
  })
  sign_define("DapStopped", {
    linehl = "GitSignsChangeLn",
    text = "",
    texthl = "GitSignsChange",
    numhl = "",
  })
  sign_define("DapBreakpointRejected", {
    linehl = "",
    text = "",
    texthl = "",
    numhl = "",
  })

  local keymap_set = vim.keymap.set

  keymap_set("n", "<F5>", dap.continue)
  keymap_set("n", "<F9>", dap.toggle_breakpoint)

  local dapui = require("dapui")
  local o_columns = vim.o.columns

  dapui.setup({
    layouts = {
      {
        elements = {
          "scopes",
          "watches",
          "stacks",
          "breakpoints",
        },
        size = math.floor((o_columns / (
          o_columns >= 160 and 3 or 2
        )) / 2),
        position = "left",
      },
      {
        elements = { "console",  "repl" },
        size = 0.25,
        position = "bottom",
      },
    },
    controls = {
      icons = {
        pause = "",
        play = "",
        step_into = "",
        step_over = "",
        step_out = "",
        step_back = "",
        run_last = "",
        terminate = "",
      },
    },
  })

  local dap_listeners = dap.listeners
  local dapui_close = dapui.close
  local repl_close = dap.repl.close

  dap_listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()

    local dap_terminate = function()
      dap.terminate(); dapui_close(); repl_close()
    end
    local keymap_set = vim.keymap.set

    keymap_set("n", "<S-F5>", dap_terminate)
    keymap_set("n", "<F17>", dap_terminate)
    keymap_set("n", "<F6>", dap.pause)
    keymap_set("n", "<F10>", dap.step_over)
    keymap_set("n", "<F11>", dap.step_into)

    local step_out = dap.step_out

    keymap_set("n", "<S-F11>", step_out)
    keymap_set("n", "<F23>", step_out)
  end

  local listeners_before = dap_listeners.before
  local keymaps_del = function()
    local keymap_del = vim.keymap.del

    keymap_del("n", "<S-F5>")
    keymap_del("n", "<F17>")
    keymap_del("n", "<F6>")
    keymap_del("n", "<F10>")
    keymap_del("n", "<F11>")
    keymap_del("n", "<S-F11>")
    keymap_del("n", "<F23>")
  end

  listeners_before.event_terminated["dapui_config"] = function()
    dapui_close(); repl_close(); keymaps_del()
  end
  listeners_before.event_exited["dapui_config"] = function()
    dapui_close(); repl_close(); keymaps_del()
  end
end

return M