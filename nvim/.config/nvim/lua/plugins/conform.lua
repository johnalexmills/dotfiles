return {
  "stevearc/conform.nvim",
  cmd = "ConformInfo",
  event = { "BufWritePre" },
  keys = {
    {
      "<leader>lf",
      function()
        require("conform").format()
      end,
      desc = "Format",
    },
  },
  config = function()
    local conform = require "conform"

    -- Custom formatter for hclfmt (generic HCL, used by Terragrunt)
    conform.formatters.hclfmt = {
      command = "hclfmt",
      stdin = true,
    }

    conform.setup {
      formatters_by_ft = {
        lua = { "stylua" },
        -- Python: handled by ruff LSP (formatting + import sorting via code actions)
        json = { "prettier" },
        yaml = { "prettier" },
        yml = { "prettier" },
        toml = { "taplo" },
        markdown = { "prettier" },
        terraform = { "terraform_fmt" },
        hcl = { "hclfmt" },
        gdscript = { "gdformat" },
        ruby = { "rubocop" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
      },
    }
  end,
}
