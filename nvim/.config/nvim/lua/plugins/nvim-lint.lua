return {
  "mfussenegger/nvim-lint",
  event = "VeryLazy",
  config = function()
    local lint = require "lint"

    -- Configure linters by filetype
    lint.linters_by_ft = {

      -- Scripting Languages
      python = { "ruff", "mypy" },
      lua = { "luacheck" },
      sh = { "shellcheck" },
      bash = { "shellcheck" },
      zsh = { "shellcheck" },
      fish = { "fish" },

      -- Configuration Languages
      yaml = { "yamllint" },
      json = { "jsonlint" },
      toml = { "taplo" },
      terraform = { "tflint" },
      tf = { "tflint" },

      -- Documentation
      markdown = { "markdownlint" },
      tex = { "chktex" },

      -- Data Languages
      sql = { "sqlfluff" },

      -- Game Development
      gdscript = { "gdtoolkit" },

      -- Other Languages
      vim = { "vint" },
      dockerfile = { "hadolint" },
      ruby = { "rubocop" },
    }

    -- Customize specific linters
    lint.linters.luacheck.args = {
      "--globals",
      "vim",
      "--formatter",
      "plain",
      "--codes",
      "--ranges",
      "-",
    }

    -- Python: Configure ruff for fast linting
    lint.linters.ruff.args = {
      "check",
      "--force-exclude",
      "--quiet",
      "--stdin-filename",
      function()
        return vim.api.nvim_buf_get_name(0)
      end,
      "--no-fix",
      "--output-format",
      "json",
      "-",
    }

    -- Bash: Configure shellcheck
    lint.linters.shellcheck.args = {
      "--format",
      "json",
      "--external-sources",
      "-",
    }

    -- YAML: Configure yamllint
    lint.linters.yamllint.args = {
      "--format",
      "parsable",
      "-",
    }

    -- Auto-lint on specific events
    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        -- Only lint if the buffer is not too large (performance)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(0))
        if ok and stats and stats.size > max_filesize then
          return
        end

        lint.try_lint()
      end,
    })

    -- Manual linting command
    vim.api.nvim_create_user_command("Lint", function()
      lint.try_lint()
    end, {})

    -- Key mappings
    vim.keymap.set("n", "<leader>ll", function()
      lint.try_lint()
    end, { desc = "Trigger linting for current file" })

    vim.keymap.set("n", "<leader>lL", function()
      -- Lint all open buffers
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_get_option(buf, "buflisted") then
          vim.api.nvim_buf_call(buf, function()
            lint.try_lint()
          end)
        end
      end
    end, { desc = "Trigger linting for all open buffers" })
  end,
}

