return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    local configs = require "nvim-treesitter.configs"

    -- Windows-specific configuration
    if vim.fn.has("win32") == 1 then
      require("nvim-treesitter.install").compilers = { "clang", "gcc" }
      require("nvim-treesitter.install").prefer_git = true
    end

    configs.setup {
      ensure_installed = { "lua", "python", "bash", "markdown", "json", "terraform" },
      auto_install = true,
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = "<C-s>",
          node_decremental = "<M-space>",
        },
      },
    }
  end,
}
