return {
  "mfussenegger/nvim-dap",
  keys = {
    {
      "<F9>",
      function()
        require("dap").toggle_breakpoint()
      end,
    },
    {
      "<F5>",
      function()
        require("dap").continue()
      end,
    },
  },
  dependencies = {
    {
      "rcarriga/nvim-dap-ui",
      config = function()
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
      end,
    },
    {
      "rcarriga/cmp-dap",
      dependencies = "hrsh7th/nvim-cmp",
      config = function()
        require("cmp").setup.filetype({
          "dap-repl",
          "dapui_watches",
          "dapui_hover",
        }, { sources = require("cmp").config.sources({ { name = "dap", keyword_lenght = 1 } }) })
      end,
    },
    {
      "jay-babu/mason-nvim-dap.nvim",
      dependencies = "williamboman/mason.nvim",
      config = function()
        require("mason-nvim-dap").setup({ ensure_installed = { "firefox", "node2" } })
      end,
    },
  },
  config = function()
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
          cwd = vim.loop.cwd(),
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

    require("dap").listeners.after.event_initialized["dapui_config"] = function()
      vim.api.nvim_set_keymap("n", "<F35>", "", {
        callback = function()
          require("dap").step_into({ ask_for_targets = true })
        end,
      })

      vim.api.nvim_set_keymap("n", "<F11>", "", {
        callback = function()
          require("dap").step_into()
        end,
      })

      vim.api.nvim_set_keymap("n", "<F17>", "", {
        callback = function()
          require("dap").terminate()
          require("dapui").close()
          require("dap").repl.close()
        end,
      })

      vim.api.nvim_set_keymap("n", "<F6>", "", {
        callback = function()
          require("dap").pause()
        end,
      })

      vim.api.nvim_set_keymap("n", "<F10>", "", {
        callback = function()
          require("dap").step_over()
        end,
      })

      vim.api.nvim_set_keymap("n", "<F23>", "", {
        callback = function()
          require("dap").step_out()
        end,
      })

      vim.api.nvim_set_keymap("n", "<F41>", "", {
        callback = function()
          require("dap").run_last()
        end,
      })

      require("dapui").open()
    end

    require("dap").listeners.before.event_exited["dapui_config"] = function()
      vim.api.nvim_del_keymap("n", "<F6>")
      vim.api.nvim_del_keymap("n", "<F10>")
      vim.api.nvim_del_keymap("n", "<F11>")
      vim.api.nvim_del_keymap("n", "<F17>") -- S-F5
      vim.api.nvim_del_keymap("n", "<F23>") -- S-F11
      vim.api.nvim_del_keymap("n", "<F35>") -- C-F11
      vim.api.nvim_del_keymap("n", "<F41>") -- S-C-F5

      require("dapui").close()
      require("dap").repl.close()
    end

    require("dap").listeners.before.event_terminated["dapui_config"] = function()
      vim.api.nvim_del_keymap("n", "<F6>")
      vim.api.nvim_del_keymap("n", "<F10>")
      vim.api.nvim_del_keymap("n", "<F11>")
      vim.api.nvim_del_keymap("n", "<F17>") -- S-F5
      vim.api.nvim_del_keymap("n", "<F23>") -- S-F11
      vim.api.nvim_del_keymap("n", "<F35>") -- C-F11
      vim.api.nvim_del_keymap("n", "<F41>") -- S-C-F5

      require("dapui").close()
      require("dap").repl.close()
    end
  end,
}
