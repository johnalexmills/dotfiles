return {
  "stevearc/conform.nvim",
  event = { "BufReadPost", "BufNewFile" },
  cond = function()
    return vim.bo.filetype ~= "oil"
  end,
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
