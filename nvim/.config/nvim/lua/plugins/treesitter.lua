return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    local configs = require "nvim-treesitter.configs"

    -- Windows-specific configuration
    if vim.fn.has "win32" == 1 then
      require("nvim-treesitter.install").compilers = { "gcc" }
      require("nvim-treesitter.install").prefer_git = true
    end

    configs.setup {
      ensure_installed = { "lua", "python", "bash", "markdown", "json", "terraform" },
      auto_install = true,
      sync_install = false,
      highlight = {
        enable = true,
        -- Disable slow treesitter highlight for large files
        disable = function(lang, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
      },
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
