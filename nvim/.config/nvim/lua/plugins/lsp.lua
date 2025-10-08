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
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("mason-lspconfig").setup {
        ensure_installed = {
          -- LSP servers
          "pyright",
          "lua_ls",
          "bashls",
          "terraformls",
        },
        automatic_installation = true,
      }
    end,
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("mason-tool-installer").setup {
        ensure_installed = {
          -- LSP servers (also handled by mason-lspconfig)
          "pyright",
          "lua-language-server",
          "bash-language-server",
          "terraform-ls",

          -- Formatters
          "stylua", -- lua
          "black", -- python
          "isort", -- python
          "ruff", -- python (also linter)
          "prettier", -- json, yaml, markdown
          "taplo", -- toml

          -- Linters
          "luacheck", -- lua
          "mypy", -- python
          "shellcheck", -- bash/sh
          "yamllint", -- yaml
          "jsonlint", -- json
          "markdownlint-cli", -- markdown
          "tflint", -- terraform

          -- Additional tools that might be useful
          "hadolint", -- dockerfile
          "sqlfluff", -- sql
        },
        auto_update = false,
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
      { "<leader>l", group = "LSP" },
      { "<leader>lD", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document Diagnostics" },
      { "<leader>lI", "<cmd>Mason<cr>", desc = "Mason Installer" },
      { "<leader>lL", "<cmd>lua vim.lsp.codelens.run()<cr>", desc = "CodeLens Action" },
      { "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Workspace Symbols" },
      { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Action" },
      { "<leader>lf", "<cmd>lua require'conform'.format()<cr>", desc = "Format" },
      { "<leader>li", "<cmd>LspInfo<cr>", desc = "Info" },
      { "<leader>lj", "<cmd>lua vim.diagnostic.goto_next()<CR>", desc = "Next Diagnostic" },
      { "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev()<cr>", desc = "Prev Diagnostic" },

      { "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<cr>", desc = "Quickfix" },
      { "<leader>lR", "<cmd>Telescope lsp_references<cr>", desc = "References" },
      { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename" },
      { "<leader>lx", "<cmd>lua vim.diagnostic.reset()<cr>", desc = "Refresh Diagnostics" },
      { "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols" },
      { "<leader>lt", "<cmd>Telescope lsp_type_definitions<cr>", desc = "Type Definitions" },
      { "<leader>lw", "<cmd>Telescope diagnostics<cr>", desc = "Workspace Diagnostics" },
      { "<leader>lm", "<cmd>Telescope lsp_implementations<cr>", desc = "Implementations" },
      {
        "<leader>ld",
        function()
          require("tiny-inline-diagnostic").toggle()
        end,
        desc = "Toggle Inline Diagnostics",
      },
    },
    config = function()
      -- Configure tiny-inline-diagnostic
      vim.diagnostic.config {
        virtual_text = false,
      }
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
            enabled = true,
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

      local capabilities = require("blink.cmp").get_lsp_capabilities()

      -- Configure LSP servers using Neovim 0.11+ native config
      vim.lsp.config.pyright = {
        capabilities = capabilities,
        filetypes = { "python" },
        root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
      }

      vim.lsp.config.lua_ls = {
        capabilities = capabilities,
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
              -- handles the vim missing error message
              globals = { "ConfigMode", "vim" },
            },
          },
        },
      }

      vim.lsp.config.bashls = {
        capabilities = capabilities,
        filetypes = { "sh", "bash" },
        root_markers = { ".git" },
      }

      vim.lsp.config.terraformls = {
        capabilities = capabilities,
        filetypes = { "terraform", "tf" },
        root_markers = { ".terraform", ".git" },
      }

      vim.lsp.config.gdscript = {
        capabilities = capabilities,
        filetypes = { "gdscript" },
        root_markers = { "project.godot", ".git" },
      }

      -- Enable all configured LSP servers
      vim.lsp.enable { "pyright", "lua_ls", "bashls", "terraformls", "gdscript" }

      -- Enable inlay hints globally (Neovim 0.10+)
      if vim.lsp.inlay_hint then
        vim.lsp.inlay_hint.enable(true)
      end

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
          source = "always",
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

          -- Enable completion triggered by <c-x><c-o>
          vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

          -- Enable semantic tokens if supported
          if client and client.server_capabilities.semanticTokensProvider then
            vim.lsp.semantic_tokens.start(ev.buf, client.id)
          end

          -- Buffer local mappings.
          local opts = { buffer = ev.buf }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
          vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
          vim.keymap.set("n", "<leader>lh", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
          end, { buffer = ev.buf, desc = "Toggle Inlay Hints" })

          -- Document highlight
          if client and client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_augroup("lsp_document_highlight", {})
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = ev.buf,
              group = "lsp_document_highlight",
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd("CursorMoved", {
              buffer = ev.buf,
              group = "lsp_document_highlight",
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })
    end,
  },
}
