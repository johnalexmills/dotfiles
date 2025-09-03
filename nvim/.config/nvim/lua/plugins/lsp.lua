return {
  {
    "williamboman/mason.nvim",
    event = { "BufReadPre", "BufNewFile" },
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
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    event = "VeryLazy",
    config = function()
      require("mason-tool-installer").setup {
        ensure_installed = {
          "stylua",
          "black",
          "debugpy",
          "isort",
          "prettier",
          "yamllint",
          "shellcheck",
          "ruff",
          "markdownlint",
        },
        run_on_start = false,
      }
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      auto_install = true,
      ensure_installed = {
        "bashls",
        "pyright",
        "lua_ls",
        "terraformls",
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "williamboman/mason-lspconfig.nvim", "saghen/blink.cmp" },
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
      { "<leader>ll", "<cmd>lua require('lint').try_lint()<cr>", desc = "Lint" },
      { "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<cr>", desc = "Quickfix" },
      { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename" },
      { "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols" },
      { "<leader>lw", "<cmd>Telescope diagnostics<cr>", desc = "Workspace Diagnostics" },
      { "<leader>ld", function() require("tiny-inline-diagnostic").toggle() end, desc = "Toggle Inline Diagnostics" },
    },
    config = function()
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

      -- Enable inlay hints globally
      vim.lsp.inlay_hint.enable(true)

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
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "<leader>lh", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
          end, { buffer = ev.buf, desc = "Toggle Inlay Hints" })
        end,
      })
    end,
  },
}
