--    You must to install the plugs bellow on config/lazy.lua
--    { import = "lazyvim.plugins.extras.dap.core" },
--    { import = "lazyvim.plugins.extras.lsp.none-ls" },

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed = { "php" }
      end
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = function(_, opts)
      opts.ensure_installed = { "phpactor" }
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    opts = function(_, opts)
      opts.ensure_installed = { "php-cs-fixer" }
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
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

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        "php",
      },
    },
  },
  { "nvim-neotest/nvim-nio" },
}
