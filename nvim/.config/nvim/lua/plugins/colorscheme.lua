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
      -- NOTE: there is no "treesitter" integration. Treesitter highlight groups
      -- live in catppuccin/groups/treesitter.lua (a core group, always applied),
      -- not in groups/integrations/, so setting it here was silently ignored.
      -- Enabled explicitly rather than via auto_integrations, which rescans the
      -- plugin list on every setup. Keep this in sync when adding plugins.
      integrations = {
        blink_cmp = true,
        gitsigns = true,
        which_key = true,
        snacks = true,
        mason = true,
        mini = true,
        harpoon = true,
        neotest = true,
        lsp_trouble = true,
        render_markdown = true,
        diffview = true, -- defaults to false upstream
        notifier = true, -- snacks.notifier
        dashboard = true,
        -- NOTE: native_lsp and semantic_tokens are NOT integrations either;
        -- they are core groups (groups/lsp.lua, groups/semantic_tokens.lua).
        -- Diagnostic styling is configured via the lsp_styles block above.
      },
    }
    -- v2.0+: the colorscheme name is "catppuccin-nvim" (was "catppuccin").
    vim.cmd.colorscheme "catppuccin-nvim"

    -- Snacks indent guide highlight groups — Catppuccin Mocha palette
    local mocha = require("catppuccin.palettes").get_palette "mocha"
    vim.api.nvim_set_hl(0, "SnacksIndentScope", { fg = mocha.lavender, nocombine = true })
  end,
}
