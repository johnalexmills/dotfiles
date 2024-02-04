return {
  "catppuccin/nvim",
  lazy = false,
  priority = 1000,
  name = "catppuccin-mocha",
  config = function()
    require("catppuccin").setup {
      flavour = "mocha",
      transparent_background = true,
    }
    vim.cmd.colorscheme "catppuccin-mocha"
  end,
  --
  -- "folke/tokyonight.nvim",
  -- lazy = false, -- make sure we load this during startup if it is your main colorscheme
  -- priority = 1000, -- make sure to load this before all the other start plugins
  -- name = "tokyonight-night",
  -- config = function()
  -- require("tokyonight").setup {
  -- transparent = true,
  -- }
  --   vim.cmd.colorscheme "tokyonight-night"
  -- end,
  -- "rose-pine/neovim",
  -- lazy = false,
  -- priority = 1000,
  -- name = "rose-pine",
  -- config = function()
  --   require("rose-pine").setup {
  --     variant = "main",
  --     styles = {
  --       transparency = true,
  --     },
  --   }
  --   vim.cmd.colorscheme "rose-pine"
  -- end,
}
