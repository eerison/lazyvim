-- it will be used for default lazyvim dap
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

return {
  -- Test
  {
    "nvim-neotest/neotest",
    dependencies = {
      "olimorris/neotest-phpunit",
    },
    opts = {
      adapters = {
        ["neotest-phpunit"] = {
          dap = dap.configurations.php[1], -- ISSUE: it isn't working
          env = {
            XDEBUG_CONFIG = "idekey=neotest", -- ISSUE: It isn't working!
            CONTAINER = "easy-php-setup-php-1",
            -- REMOTE_PHPUNIT_BIN = "bin/codecept run",
            REMOTE_PHPUNIT_BIN = "vendor/bin/phpunit",
          },
          filter_dirs = { "vendor" },
          -- phpunit_cmd = "nvim/neotest",
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
    "mason-org/mason.nvim",
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
