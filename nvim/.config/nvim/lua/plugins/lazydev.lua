return {
  "folke/lazydev.nvim",
  ft = "lua",
  opts = {
    library = {
      -- Load luvit types when the `vim.uv` word is found
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      -- Types for the global `Snacks` used throughout plugins/*.lua
      { path = "snacks.nvim", words = { "Snacks" } },
    },
  },
}
