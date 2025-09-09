return {
  "folke/which-key.nvim",
  keys = { "<leader>", "<c-w>", '"', "'", "`", "c", "v", "g" },
  cmd = "WhichKey",
  opts = {},
  config = function(_, opts)
    require("which-key").setup(opts)
    require("which-key").add(require "keymaps")
  end,
}
