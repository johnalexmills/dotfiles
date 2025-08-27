return {
  "catppuccin/nvim",
  lazy = false,
  priority = 1000,
  name = "catppuccin",
  config = function()
    require("catppuccin").setup {
      flavour = "mocha",
      transparent_background = true,
      term_colors = true,
      compile_path = vim.fn.stdpath "cache" .. "/catppuccin",
      styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        keywords = { "italic" },
        types = { "italic" },
      },
      integrations = {
        cmp = true,
        gitsigns = true,
        treesitter = true,
        which_key = true,
        telescope = { enabled = true },
        illuminate = { enabled = true, lsp = false },
        alpha = true,
        fidget = true,
        lualine = true,
        mason = true,
        indent_blankline = { enabled = true },
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
            ok = { "italic" },
          },
          underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
            ok = { "underline" },
          },
          inlay_hints = {
            background = true,
          },
        },
      },
    }
    vim.cmd.colorscheme "catppuccin"
  end,
  -- {
  --   "folke/tokyonight.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     require("tokyonight").setup {
  --       style = "night",
  --       light_style = "day",
  --       transparent = true,
  --       terminal_colors = true,
  --       styles = {
  --         comments = { italic = true },
  --         keywords = { italic = true },
  --         functions = { italic = true },
  --         variables = { italic = true },
  --         sidebars = "transparent",
  --         floats = "transparent",
  --       },
  --       sidebars = { "qf", "help", "vista_kind", "terminal", "packer" },
  --       day_brightness = 0.3,
  --       dim_inactive = false,
  --       lualine_bold = false,
  --       cache = true,
  --       plugins = {
  --         auto = true,
  --         all = true,
  --       },
  --     }
  --     vim.cmd.colorscheme "tokyonight-night"
  --   end,
  -- },
}
