return {
  "stevearc/conform.nvim",
  cmd = "ConformInfo",
  keys = {
    { "<leader>lf", "<cmd>lua require'conform'.format()<cr>", desc = "Format" },
  },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "black", "isort", "ruff" },
      json = { "prettier" },
      yaml = { "prettier" },
      yml = { "prettier" },
      toml = { "taplo" },
      markdown = { "prettier" },
      terraform = { "terraform_fmt" },
      hcl = { "terraform_fmt" },
    },
    -- format_on_save = {
    --   lsp_fallback = true,
    --   async = false,
    -- },
  },
}
