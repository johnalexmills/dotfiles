return {
  "catppuccin/nvim",
  lazy = false,
  priority = 1000,
  name = "catppuccin",
  config = function()
    require("catppuccin").setup {
      flavour = "mocha",
      transparent_background = false,
      term_colors = true,
      styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        keywords = { "italic" },
        types = { "italic" },
      },
      -- v2.0+ moved diagnostic styling out of integrations.native_lsp into a
      -- top-level lsp_styles block.
      lsp_styles = {
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
      integrations = {
        blink_cmp = true,
        gitsigns = true,
        treesitter = true,
        which_key = true,
        snacks = true,
        mason = true,
        mini = true,
      },
    }
    -- v2.0+: the colorscheme name is "catppuccin-nvim" (was "catppuccin").
    vim.cmd.colorscheme "catppuccin-nvim"

    -- Snacks indent guide highlight groups — Catppuccin Mocha palette
    local mocha = require("catppuccin.palettes").get_palette "mocha"
    vim.api.nvim_set_hl(0, "SnacksIndentScope", { fg = mocha.lavender, nocombine = true })
  end,
}
