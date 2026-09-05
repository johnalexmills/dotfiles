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
        -- ruff handles both formatting and import sorting, but they are two
        -- separate conform formatters and run in order.
        python = { "ruff_organize_imports", "ruff_format" },
        json = { "prettier" },
        -- NOTE: there is no "yml" filetype; .yml files are detected as "yaml".
        yaml = { "prettier" },
        toml = { "taplo" },
        markdown = { "prettier" },
        terraform = { "terraform_fmt" },
        ["terraform-vars"] = { "terraform_fmt" },
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
