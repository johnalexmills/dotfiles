return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup {
        style = "night",
        light_style = "day",
        transparent = true,
        terminal_colors = true,
        styles = {
          comments = { italic = true },
          keywords = { italic = true },
          functions = { italic = true },
          variables = { italic = true },
          sidebars = "transparent",
          floats = "transparent",
        },
        sidebars = { "qf", "help", "vista_kind", "terminal", "packer" },
        day_brightness = 0.3,
        dim_inactive = false,
        lualine_bold = false,
        cache = true,
        plugins = {
          auto = true,
          all = true,
        },
      }
      vim.cmd.colorscheme "tokyonight-night"
    end,
  },
}
