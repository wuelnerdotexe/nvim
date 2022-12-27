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

  local call_function = vim.api.nvim_call_function

  for _, language in ipairs({ "javascript", "javascriptreact", "typescript", "typescriptreact" }) do
    require("dap").configurations[language] = {
      {
        name = "Launch Node against current file",
        type = "node2",
        request = "launch",
        program = "${file}",
        cwd = call_function("getcwd", {}),
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

  local sign_define = function(name, tbl)
    call_function("sign_define", { name, tbl })
  end

  sign_define("DapBreakpoint", { linehl = "", text = "", texthl = "GitSignsDelete", numhl = "" })
  sign_define("DapBreakpointCondition", { linehl = "", text = "", texthl = "GitSignsDelete", numhl = "" })
  sign_define("DapLogPoint", { linehl = "", text = "", texthl = "GitSignsDelete", numhl = "" })
  sign_define("DapStopped", { linehl = "GitSignsChangeLn", text = "", texthl = "GitSignsChange", numhl = "" })
  sign_define("DapBreakpointRejected", { linehl = "", text = "", texthl = "", numhl = "" })

  local set_keymap = vim.api.nvim_set_keymap

  set_keymap("n", "<F5>", "", {
    callback = function()
      require("dap").continue()
    end,
  })

  set_keymap("n", "<F9>", "", {
    callback = function()
      require("dap").toggle_breakpoint()
    end,
  })

  local columns = vim.api.nvim_get_option_value("columns", {})

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
    set_keymap("n", "<F6>", "", {
      callback = function()
        require("dap").pause()
      end,
    })

    set_keymap("n", "<F10>", "", {
      callback = function()
        require("dap").step_over()
      end,
    })

    local step_into = require("dap").step_into

    set_keymap("n", "<F11>", "", {
      callback = function()
        step_into()
      end,
    })

    local step_into_targets = function()
      step_into({ ask_for_targets = true })
    end

    set_keymap("n", "<C-F11>", "", {
      callback = function()
        step_into_targets()
      end,
    })

    set_keymap("n", "<F35>", "", {
      callback = function()
        step_into_targets()
      end,
    })

    local step_out = require("dap").step_out

    set_keymap("n", "<S-F11>", "", {
      callback = function()
        step_out()
      end,
    })

    set_keymap("n", "<F23>", "", {
      callback = function()
        step_out()
      end,
    })

    local run_last = require("dap").run_last

    set_keymap("n", "<C-S-F5>", "", {
      callback = function()
        run_last()
      end,
    })

    set_keymap("n", "<F41>", "", {
      callback = function()
        run_last()
      end,
    })

    local dap_terminate = function()
      require("dap").terminate(); dapui_close(); repl_close()
    end

    set_keymap("n", "<S-F5>", "", {
      callback = function()
        dap_terminate()
      end,
    })

    set_keymap("n", "<F17>", "", {
      callback = function()
        dap_terminate()
      end,
    })

    require("dapui").open()
  end

  local del_keymap = vim.api.nvim_del_keymap
  local keymaps_del = function()
    del_keymap("n", "<F6>")
    del_keymap("n", "<F10>")
    del_keymap("n", "<F11>")
    del_keymap("n", "<C-F11>")
    del_keymap("n", "<F35>")
    del_keymap("n", "<S-F11>")
    del_keymap("n", "<F23>")
    del_keymap("n", "<C-S-F5>")
    del_keymap("n", "<F41>")
    del_keymap("n", "<S-F5>")
    del_keymap("n", "<F17>")
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
