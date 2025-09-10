return {
  "catppuccin/nvim",
  lazy = false,
  priority = 1000,
  name = "catppuccin",
  config = function()
    require("catppuccin").setup {
      flavour = "macchiato",
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

        lualine = true,
        mason = true,
        mini = true,
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
}
