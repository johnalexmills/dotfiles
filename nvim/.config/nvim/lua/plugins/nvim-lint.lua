return {
  "mfussenegger/nvim-lint",
  -- Must load before the BufReadPost autocmd below can fire. On VeryLazy the
  -- first file opened was already past BufReadPost and so never got linted.
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require "lint"

    -- Configure linters by filetype
    -- NOTE: Python lint+format is handled by ruff LSP; type-checking by ty LSP.
    lint.linters_by_ft = {

      -- Scripting Languages
      lua = { "luacheck" },
      sh = { "shellcheck" },
      bash = { "shellcheck" },
      fish = { "fish" },

      -- Configuration Languages
      yaml = { "yamllint" },
      json = { "jsonlint" },

      -- Documentation
      markdown = { "markdownlint" },

      -- Game Development
      gdscript = { "gdlint" },

      -- Other Languages
      dockerfile = { "hadolint" },
    }

    -- Customize specific linters
    lint.linters.luacheck.args = {
      "--globals",
      "vim",
      "Snacks",
      "--formatter",
      "plain",
      "--codes",
      "--ranges",
      "-",
    }

    -- shellcheck: extend upstream's args rather than replacing them. A full
    -- override pinned `--format json` after nvim-lint switched its parser to
    -- json1 (May 2025), which silently produced zero diagnostics.
    table.insert(lint.linters.shellcheck.args, 1, "--external-sources")

    -- Auto-lint on specific events
    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        -- Only lint if the buffer is not too large (performance)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(0))
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
        if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted then
          vim.api.nvim_buf_call(buf, function()
            lint.try_lint()
          end)
        end
      end
    end, { desc = "Trigger linting for all open buffers" })
  end,
}
