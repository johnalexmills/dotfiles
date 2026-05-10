return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "nvim-neotest/neotest-python",
    },
    cmd = { "Neotest" },
    keys = {
      {
        "<leader>nt",
        function()
          require("neotest").run.run()
        end,
        desc = "Run nearest test",
      },
      {
        "<leader>nf",
        function()
          require("neotest").run.run(vim.fn.expand "%")
        end,
        desc = "Run file tests",
      },
      {
        "<leader>ns",
        function()
          require("neotest").run.run { suite = true }
        end,
        desc = "Run test suite",
      },
      {
        "<leader>nl",
        function()
          require("neotest").run.run_last()
        end,
        desc = "Run last test",
      },
      {
        "<leader>nd",
        function()
          require("neotest").run.run { strategy = "dap" }
        end,
        desc = "Debug nearest test",
      },
      {
        "<leader>no",
        function()
          require("neotest").output.open { enter = true, auto_close = true }
        end,
        desc = "Show test output",
      },
      {
        "<leader>nO",
        function()
          require("neotest").output_panel.toggle()
        end,
        desc = "Toggle output panel",
      },
      {
        "<leader>np",
        function()
          require("neotest").summary.toggle()
        end,
        desc = "Toggle test summary panel",
      },
      {
        "<leader>nq",
        function()
          require("neotest").run.stop()
        end,
        desc = "Stop running tests",
      },
      {
        "]n",
        function()
          require("neotest").jump.next { status = "failed" }
        end,
        desc = "Next failed test",
      },
      {
        "[n",
        function()
          require("neotest").jump.prev { status = "failed" }
        end,
        desc = "Prev failed test",
      },
    },
    config = function()
      require("neotest").setup {
        adapters = {
          require "neotest-python" {
            -- Use pytest by default; falls back to unittest if no pytest config found
            runner = "pytest",
            -- Pass pytest args (e.g. -v for verbose output)
            args = { "--tb=short" },
            -- Automatically detect virtualenvs managed by common tools
            python = function()
              local venv_paths = {
                vim.fn.getcwd() .. "/.venv/bin/python",
                vim.fn.getcwd() .. "/venv/bin/python",
                vim.fn.getcwd() .. "/.env/bin/python",
              }
              for _, path in ipairs(venv_paths) do
                if vim.fn.executable(path) == 1 then
                  return path
                end
              end
              -- Fall back to system python
              return vim.fn.exepath "python3" or vim.fn.exepath "python" or "python"
            end,
          },
        },
        -- Show test icons in the sign column
        icons = {
          failed = "✘",
          passed = "✓",
          running = "↻",
          skipped = "⊘",
          unknown = "?",
        },
        -- Diagnostic config: show errors inline
        diagnostic = {
          enabled = true,
          severity = vim.diagnostic.severity.ERROR,
        },
        status = {
          enabled = true,
          signs = true,
          virtual_text = false,
        },
        output = {
          enabled = true,
          open_on_run = false, -- Don't auto-open output; use <leader>no to open manually
        },
        summary = {
          enabled = true,
          animated = true,
          follow = true, -- Auto-follow the running test in the summary panel
          expand_errors = true,
        },
      }
    end,
  },
}
