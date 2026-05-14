return {
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    config = function()
      require("mason").setup {
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      }
    end,
  },

  {
    -- Bridges Mason package names <-> nvim-lspconfig server names (e.g.
    -- "lua-language-server" <-> "lua_ls"). Required for some setups but
    -- mainly used here for ensure_installed of LSP servers.
    --
    -- NOTE: ty (Astral's Python type checker LSP) is not yet auto-recognised
    -- by mason-lspconfig (see https://github.com/mason-org/mason-lspconfig.nvim/issues/642).
    -- We install ty via mason-tool-installer below and enable it manually with
    -- vim.lsp.enable('ty').
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("mason-lspconfig").setup {}
    end,
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("mason-tool-installer").setup {
        ensure_installed = {
          -- LSP servers
          "lua-language-server",
          "bash-language-server",
          "terraform-ls",
          "yaml-language-server",
          "ty", -- Python type checker LSP (Astral)
          "ruff", -- Python linter/formatter LSP (Astral)

          -- Formatters (non-LSP)
          "stylua", -- lua
          "prettier", -- json, yaml, markdown
          "taplo", -- toml
          "hclfmt", -- hcl (terragrunt)

          -- Linters (non-LSP)
          "luacheck", -- lua
          "shellcheck", -- bash/sh
          "yamllint", -- yaml
          "jsonlint", -- json
          "markdownlint", -- markdown
          "tflint", -- terraform

          -- Multi-purpose (linter + formatter)
          "gdtoolkit", -- gdscript (gdlint + gdformat)
          "rubocop", -- ruby

          -- Additional tools
          "hadolint", -- dockerfile
          "sqlfluff", -- sql
        },
        auto_update = true,
        run_on_start = true,
      }
    end,
  },

  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "saghen/blink.cmp",
      "rachartier/tiny-inline-diagnostic.nvim",
    },
    keys = {
      {
        "<leader>lD",
        function()
          Snacks.picker.diagnostics_buffer()
        end,
        desc = "Document Diagnostics",
      },
      { "<leader>lI", "<cmd>Mason<cr>", desc = "Mason Installer" },
      {
        "<leader>lS",
        function()
          Snacks.picker.lsp_workspace_symbols()
        end,
        desc = "Workspace Symbols",
      },
      { "<leader>la", vim.lsp.buf.code_action, desc = "Code Action" },
      { "<leader>li", "<cmd>checkhealth vim.lsp<cr>", desc = "Info" },
      {
        "<leader>lj",
        function()
          vim.diagnostic.jump { count = 1 }
        end,
        desc = "Next Diagnostic",
      },
      {
        "<leader>lk",
        function()
          vim.diagnostic.jump { count = -1 }
        end,
        desc = "Prev Diagnostic",
      },
      { "<leader>lq", vim.diagnostic.setloclist, desc = "Quickfix" },
      {
        "<leader>lR",
        function()
          Snacks.picker.lsp_references()
        end,
        desc = "References",
      },
      { "<leader>lr", vim.lsp.buf.rename, desc = "Rename" },
      { "<leader>lx", vim.diagnostic.reset, desc = "Refresh Diagnostics" },
      {
        "<leader>ls",
        function()
          Snacks.picker.lsp_symbols()
        end,
        desc = "Document Symbols",
      },
      {
        "<leader>lt",
        function()
          Snacks.picker.lsp_type_definitions()
        end,
        desc = "Type Definitions",
      },
      {
        "<leader>lw",
        function()
          Snacks.picker.diagnostics()
        end,
        desc = "Workspace Diagnostics",
      },
      {
        "<leader>lm",
        function()
          Snacks.picker.lsp_implementations()
        end,
        desc = "Implementations",
      },
      {
        "<leader>ld",
        function()
          require("tiny-inline-diagnostic").toggle()
        end,
        desc = "Toggle Inline Diagnostics",
      },
    },
    config = function()
      require("tiny-inline-diagnostic").setup {
        preset = "modern",
        hi = {
          error = "DiagnosticError",
          warn = "DiagnosticWarn",
          info = "DiagnosticInfo",
          hint = "DiagnosticHint",
          arrow = "NonText",
          background = "CursorLine",
          mixing_color = "Normal",
        },
        options = {
          show_source = {
            enabled = true,
            if_many = true,
          },
          throttle = 20,
          softwrap = 15,
          multilines = {
            enabled = false,
          },
          show_all_diags_on_cursorline = false,
          enable_on_insert = false,
          enable_on_select = false,
          overflow = {
            mode = "wrap",
            padding = 0,
          },
          break_line = {
            enabled = false,
            after = 30,
          },
          virt_texts = {
            priority = 2048,
          },
          severity = {
            vim.diagnostic.severity.ERROR,
            vim.diagnostic.severity.WARN,
            vim.diagnostic.severity.INFO,
            vim.diagnostic.severity.HINT,
          },
        },
      }
      require("tiny-inline-diagnostic").enable()

      local capabilities = require("blink.cmp").get_lsp_capabilities()

      -- Configure LSP servers using Neovim 0.11+ native config (function form,
      -- which merges with anything declared in lsp/<name>.lua on the runtimepath).
      --
      -- NOTE: cmd is intentionally omitted for most servers; nvim-lspconfig
      -- (a dependency) populates default cmd / filetypes / root_dir for each
      -- known server, and our config is then merged on top, overriding only
      -- what we specify. Removing nvim-lspconfig would require adding explicit
      -- cmd fields here.

      vim.lsp.config("ty", {
        capabilities = capabilities,
        filetypes = { "python" },
        root_markers = { "ty.toml", "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
      })

      vim.lsp.config("ruff", {
        capabilities = capabilities,
        filetypes = { "python" },
        root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", ".git" },
        init_options = {
          settings = {
            -- ruff settings; defaults are sensible. Add overrides here if needed.
          },
        },
      })

      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        filetypes = { "lua" },
        root_markers = {
          ".luarc.json",
          ".luarc.jsonc",
          ".luacheckrc",
          ".stylua.toml",
          "stylua.toml",
          "selene.toml",
          "selene.yml",
          ".git",
        },
        settings = {
          Lua = {
            diagnostics = {
              globals = { "ConfigMode" },
            },
          },
        },
      })

      vim.lsp.config("bashls", {
        capabilities = capabilities,
        filetypes = { "sh", "bash" },
        root_markers = { ".git" },
      })

      vim.lsp.config("terraformls", {
        capabilities = capabilities,
        filetypes = { "terraform", "tf" },
        root_markers = { ".terraform", ".git" },
      })

      vim.lsp.config("gdscript", {
        capabilities = capabilities,
        filetypes = { "gdscript" },
        root_markers = { "project.godot", ".git" },
      })

      vim.lsp.config("yamlls", {
        capabilities = capabilities,
        filetypes = { "yaml", "yaml.docker-compose" },
        root_markers = { ".git" },
        settings = {
          yaml = {
            schemaStore = { enable = true },
            validate = true,
            format = { enable = false }, -- handled by prettier via conform
          },
        },
      })

      -- Enable all configured LSP servers
      vim.lsp.enable { "ty", "ruff", "lua_ls", "bashls", "terraformls", "gdscript", "yamlls" }

      -- Enhanced diagnostic configuration (modern features)
      vim.diagnostic.config {
        virtual_text = false,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "✘",
            [vim.diagnostic.severity.WARN] = "▲",
            [vim.diagnostic.severity.HINT] = "⚑",
            [vim.diagnostic.severity.INFO] = "»",
          },
          numhl = {
            [vim.diagnostic.severity.ERROR] = "DiagnosticError",
            [vim.diagnostic.severity.WARN] = "DiagnosticWarn",
            [vim.diagnostic.severity.HINT] = "DiagnosticHint",
            [vim.diagnostic.severity.INFO] = "DiagnosticInfo",
          },
        },
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          focusable = false,
          style = "minimal",
          border = "rounded",
          source = true,
          header = "",
          prefix = "",
          format = function(diagnostic)
            return string.format(
              "%s (%s) [%s]",
              diagnostic.message,
              diagnostic.source or "unknown",
              diagnostic.code or "no-code"
            )
          end,
        },
      }

      -- Use LspAttach autocommand to only map the following keys
      -- after the language server attaches to the current buffer
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local client = vim.lsp.get_client_by_id(ev.data.client_id)
          if not client then
            return
          end

          -- Buffer local mappings
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = ev.buf, desc = "Go to Definition" })
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = ev.buf, desc = "Go to Declaration" })
          vim.keymap.set("n", "<leader>lg", vim.lsp.buf.signature_help, { buffer = ev.buf, desc = "Signature Help" })

          -- Inlay hints: only enable for clients that support them, and provide a per-buffer toggle.
          if client:supports_method "textDocument/inlayHint" then
            vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
            vim.keymap.set("n", "<leader>lh", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = ev.buf }, { bufnr = ev.buf })
            end, { buffer = ev.buf, desc = "Toggle Inlay Hints" })
          end

          -- Document highlight
          if client:supports_method "textDocument/documentHighlight" then
            local highlight_group = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = false })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = ev.buf,
              group = highlight_group,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd("CursorMoved", {
              buffer = ev.buf,
              group = highlight_group,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })

      -- Clean up document highlight autocmds when LSP detaches
      vim.api.nvim_create_autocmd("LspDetach", {
        group = vim.api.nvim_create_augroup("UserLspDetach", {}),
        callback = function(ev)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = "lsp_document_highlight", buffer = ev.buf }
        end,
      })
    end,
  },
}
