return {
  {
    'folke/tokyonight.nvim',
    lazy=false,
    priority=1000,
  },
  {
    "dracula/vim",
    name = "dracula",
    lazy = true,
  },
  {
    "joshdick/onedark.vim",
    lazy = true,
  },
  {
    "nanotech/jellybeans.vim",
    lazy = true,
  },
  {
    "nlknguyen/papercolor-theme",
    lazy = true,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    opt = {
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      transparent_background = true, -- disables setting the background color.
    }
  },
}
