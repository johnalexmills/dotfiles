return {
  {
    "williamboman/mason.nvim",
    lazy = false,
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
    lazy = false,
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
        run_on_start = true,
      }
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
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
    lazy = false,
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local lspconfig = require "lspconfig"
      lspconfig.pyright.setup {
        capabilities = capabilities,
        filetypes = { "python" },
      }
      lspconfig.lua_ls.setup {
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "ConfigMode", "vim" },
            },
          },
        },
      }
      lspconfig.bashls.setup {
        capabilities = capabilities,
      }
      lspconfig.terraformls.setup {
        capabilities = capabilities,
      }
      -- Use LspAttach autocommand to only map the following keys
      -- after the language server attaches to the current buffer
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          -- Enable completion triggered by <c-x><c-o>
          vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

          -- Buffer local mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          local opts = { buffer = ev.buf }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        end,
      })
    end,
  },
}
