return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
  },
  { "nvim-tree/nvim-web-devicons", opts = {} },
  { "folke/tokyonight.nvim", lazy = false, priority = 1000 },
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("kanagawa").setup({})
      vim.cmd("colorscheme kanagawa")
    end,
  },
  { "EdenEast/nightfox.nvim", lazy = false, priority = 1000 },
}
