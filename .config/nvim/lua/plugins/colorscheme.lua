return {
  "catppuccin/nvim",
  lazy = false,
  priority = 1000,
  name = "catppuccin-mocha",
  config = function()
    require("catppuccin").setup {
      flavour = "mocha",
      transparent_background = true,
      term_colors = true,
      compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
      styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = { "italic" },
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = { "italic" },
        operators = {},
      },
      integrations = {
        cmp = true,
        gitsigns = true,
        treesitter = true,
        which_key = true,
        telescope = { enabled = true },
        illuminate = { enabled = true, lsp = false },
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
    vim.cmd.colorscheme "catppuccin-mocha"
  end,
}
