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
        run_on_start = true,
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
    dependencies = { "williamboman/mason-lspconfig.nvim", "hrsh7th/cmp-nvim-lsp" },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

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
