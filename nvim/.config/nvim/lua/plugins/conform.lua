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

    -- shfmt uses conform's built-in definition: it passes no style flags when
    -- an .editorconfig exists, so shfmt reads indent/switch_case_indent from
    -- there (the dotfiles repo's matches CI and the pre-commit hook), and
    -- falls back to the buffer's shiftwidth otherwise. A previous override
    -- passed `-w` while reading stdin, which shfmt rejects outright.

    conform.setup {
      formatters_by_ft = {
        lua = { "stylua" },
        sh = { "shfmt" },
        bash = { "shfmt" },
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
