return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "ninja", "rst" } },
  },
  { "neovim/nvim-lspconfig" },
  {
    "nvim-neotest/neotest-python",
  },
  {
    "linux-cultist/venv-selector.nvim",
    opts = {
      options = {
        notify_user_on_venv_activation = true,
        override_notify = false,
      },
    },
  },
  { "mfussenegger/nvim-dap-python" },
}
