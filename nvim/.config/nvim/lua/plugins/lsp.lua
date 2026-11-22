return {
  {
    "mason-org/mason.nvim",
    cmd = "Mason",
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason-org/mason.nvim" },
    event = "VeryLazy",
    config = function()
      require("mason-tool-installer").setup {
        -- Mason package names (not lspconfig server names).
        ensure_installed = {
          -- LSP servers
          "lua-language-server",
          "bash-language-server",
          "yaml-language-server",
          "ty", -- Python type checker (Astral)
          "ruff", -- Python linter/formatter (Astral)

          -- Formatters
          "stylua",
          "prettier", -- json, yaml, markdown
          "taplo", -- toml
          "shfmt",

          -- Linters
          "luacheck",
          "shellcheck",
          "yamllint",
          "jsonlint",
          "markdownlint",
          "hadolint", -- dockerfile

          -- gdscript (gdlint + gdformat); the LSP is Godot itself
          "gdtoolkit",
        },
        auto_update = false,
        run_on_start = true,
      }
      -- The plugin's own run_on_start hook fires on VimEnter, which has already
      -- passed by the time VeryLazy loads it, so trigger the missing-tool check
      -- here. Without this, ensure_installed never ran on a fresh machine.
      require("mason-tool-installer").run_on_start()
    end,
  },

  {
    -- Supplies cmd / filetypes / root_markers for every server below via its
    -- lsp/<name>.lua files. Capabilities come from blink.cmp, which registers
    -- them for all servers with vim.lsp.config("*") on its own.
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      -- mason.setup() is what puts ~/.local/share/nvim/mason/bin on PATH, so
      -- it must run before any server is spawned.
      "mason-org/mason.nvim",
      "saghen/blink.cmp",
    },
    -- Neovim's built-in LSP maps cover the rest (and are remapped to Snacks
    -- pickers in LspAttach below): grn rename, gra code action, grr refs,
    -- gri implementations, grt type definition, gO symbols, K hover,
    -- [d / ]d diagnostics, <C-s> signature help (insert).
    keys = {
      {
        "<leader>lD",
        function()
          Snacks.picker.diagnostics_buffer()
        end,
        desc = "Document Diagnostics",
      },
      {
        "<leader>lw",
        function()
          Snacks.picker.diagnostics()
        end,
        desc = "Workspace Diagnostics",
      },
      {
        "<leader>lS",
        function()
          Snacks.picker.lsp_workspace_symbols()
        end,
        desc = "Workspace Symbols",
      },
      { "<leader>lI", "<cmd>Mason<cr>", desc = "Mason Installer" },
      { "<leader>li", "<cmd>checkhealth vim.lsp<cr>", desc = "Info" },
      { "<leader>lq", vim.diagnostic.setloclist, desc = "Diagnostics to Loclist" },
      { "<leader>lx", vim.diagnostic.reset, desc = "Clear Diagnostics" },
      {
        "<leader>ld",
        function()
          local on = vim.diagnostic.config().virtual_text
          vim.diagnostic.config { virtual_text = not on and { current_line = true } or false }
        end,
        desc = "Toggle Inline Diagnostics",
      },
    },
    config = function()
      vim.lsp.config("yamlls", {
        -- lspconfig also lists yaml.docker-compose etc., which Neovim never
        -- detects and checkhealth warns about.
        filetypes = { "yaml" },
        settings = {
          yaml = {
            schemaStore = { enable = true },
            validate = true,
            format = { enable = false }, -- handled by prettier via conform
          },
        },
      })

      vim.lsp.enable { "ty", "ruff", "lua_ls", "bashls", "gdscript", "yamlls" }

      vim.diagnostic.config {
        -- Inline message for the cursor line only (<leader>ld toggles it).
        virtual_text = { current_line = true },
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
          border = "rounded",
          source = true,
        },
      }

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local client = vim.lsp.get_client_by_id(ev.data.client_id)
          if not client then
            return
          end

          local function map(lhs, picker, desc)
            vim.keymap.set("n", lhs, function()
              Snacks.picker[picker]()
            end, { buffer = ev.buf, desc = desc })
          end
          -- Snacks pickers instead of the builtins, which dump multiple
          -- results into the quickfix list without previews.
          map("gd", "lsp_definitions", "Go to Definition")
          map("gD", "lsp_declarations", "Go to Declaration")
          map("grr", "lsp_references", "References")
          map("gri", "lsp_implementations", "Implementations")
          map("grt", "lsp_type_definitions", "Type Definitions")
          map("gO", "lsp_symbols", "Document Symbols")
          vim.keymap.set("n", "<leader>lg", vim.lsp.buf.signature_help, { buffer = ev.buf, desc = "Signature Help" })

          if client:supports_method "textDocument/inlayHint" then
            vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
            vim.keymap.set("n", "<leader>lh", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = ev.buf }, { bufnr = ev.buf })
            end, { buffer = ev.buf, desc = "Toggle Inlay Hints" })
          end
          -- Reference highlighting under the cursor is done by Snacks.words.
        end,
      })
    end,
  },
}
