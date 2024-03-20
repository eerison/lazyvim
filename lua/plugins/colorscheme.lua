return {
  { -- plugin spec for catppuccin
    "catppuccin/nvim",
  },

  -- this belongs to no plugin spec and is ignored
  lazy = false,
  name = "catppuccin",
  opts = {
    transparent_background = true,
  },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-mocha",
    },
  },
}
