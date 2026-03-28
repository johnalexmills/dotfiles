return {
  "stevearc/conform.nvim",
  cmd = "ConformInfo",
  event = { "BufWritePre" },
  keys = {
    { "<leader>lf", "<cmd>lua require'conform'.format()<cr>", desc = "Format" },
  },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "ruff_fix", "ruff_format" },
      json = { "prettier" },
      yaml = { "prettier" },
      yml = { "prettier" },
      toml = { "taplo" },
      markdown = { "prettier" },
      terraform = { "terraform_fmt" },
      hcl = { "terraform_fmt" },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_format = "fallback",
    },
  },
}
