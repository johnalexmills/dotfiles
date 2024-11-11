return {
  "catppuccin/nvim",
  lazy = false,
  priority = 1000,
  name = "catppuccin-mocha",
  config = function()
    require("catppuccin").setup {
      flavour = "mocha",
      -- transparent_background = true,
    }
    vim.cmd.colorscheme "catppuccin-mocha"
  end,
}
