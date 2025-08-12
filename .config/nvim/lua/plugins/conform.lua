return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "black", "isort", "ruff" },
      json = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
    },
    -- format_on_save = {
    --   lsp_fallback = true,
    --   async = false,
    -- },
  },
}
