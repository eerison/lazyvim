-- https://www.lazyvim.org/extras/lang/php

return {

  --DAP
  {
    "mfussenegger/nvim-dap",
    opts = function()
      local dap = require("dap")
      dap.adapters.php = {
        type = "executable",
        command = "node",
        args = { os.getenv("HOME") .. "/.config/nvim-external/vscode-php-debug/out/phpDebug.js" },
      }

      dap.configurations.php = {
        {
          type = "php",
          request = "launch",
          name = "Listen for Xdebug",
          port = 9003,
          pathMappings = {
            ["/app"] = "${workspaceFolder}",
          },
        },
      }
    end,
  },

  -- Test
  {
    "nvim-neotest/neotest",
    dependencies = {
      "olimorris/neotest-phpunit",
    },
    opts = {
      adapters = {
        ["neotest-phpunit"] = {
          env = {
            CONTAINER = "rcs-app-1",
            -- REMOTE_PHPUNIT_BIN = "bin/codecept run",
            REMOTE_PHPUNIT_BIN = "bin/phpunit",
          },
          phpunit_cmd = "nvim/neotest",
          -- dap = require("dap").configurations.php, -- BUG: For some reason this dap configuration does not work with this config.
        },
      },
    },
  },

  -- lint
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        php = { "php", "phpstan" },
      },
    },
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "phpstan",
        "php-cs-fixer",
      },
    },
  },

  -- format
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        php = { "php_cs_fixer" },
      },
    },
  },
}
