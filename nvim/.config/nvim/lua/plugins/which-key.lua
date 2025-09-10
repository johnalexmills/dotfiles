return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {},
  config = function(_, opts)
    require("which-key").setup(opts)
    require("which-key").add(require "keymaps")
  end,
}
