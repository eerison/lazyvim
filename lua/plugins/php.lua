--    You must to install the plugs bellow on config/lazy.lua
--    { import = "lazyvim.plugins.extras.dap.core" },
--    { import = "lazyvim.plugins.extras.lsp.none-ls" },
--    { import = "lazyvim.plugins.extras.test.core" },

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed = { "php" }
      end
    end,
  },

  -- Lsp
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = { "phpactor" },
    },
  },

  --- Formatter
  {
    "jay-babu/mason-null-ls.nvim",
    opts = {
      ensure_installed = { "php-cs-fixer" },
    },
  },

  --- Dap
  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = {
      automatic_installation = true,

      handlers = {
        php = function(config)
          config.adapters = {
            type = "executable",
            command = "node",
            args = { os.getenv("HOME") .. "/Documents/projects/vscode-php-debug/out/phpDebug.js" },
          }

          config.configurations = {
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
          require("mason-nvim-dap").default_setup(config)
        end,
      },

      ensure_installed = {
        "php",
      },
    },
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
            REMOTE_PHPUNIT_BIN = "bin/phpunit",
          },
          phpunit_cmd = function()
            return "nvim/neotest" -- docker compose -f docker/docker-compose.yml exec app bin/phpunit $1
          end,
        },
      },
    },
  },
}
