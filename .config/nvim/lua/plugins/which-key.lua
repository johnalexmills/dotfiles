local setup = {
  preset = "modern",
  icons = {
    breadcrumb = "»",
    separator = "➜",
    group = "+",
  },
  win = {
    border = "rounded",
    padding = { 2, 2, 2, 2 },
    wo = {
      winblend = 0,
    },
  },
  layout = {
    height = { min = 4, max = 25 },
    width = { min = 20, max = 50 },
    spacing = 3,
    align = "left",
  },
  show_help = true,
  show_keys = true,
}

local keymaps = require "keymaps"

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    require("which-key").setup(setup)
    require("which-key").add(keymaps)
  end,
}
