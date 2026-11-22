local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- load lazy
require("lazy").setup("plugins", {
  install = { colorscheme = { "catppuccin-nvim" } },
  defaults = { lazy = true },
  ui = { border = "rounded" },
  change_detection = { enabled = true, notify = false },
  -- Fetch in the background (hourly) to count pending updates; nothing is
  -- installed until :Lazy update. The count shows in lualine.
  checker = { enabled = true, notify = false },
  debug = false,
  performance = {
    rtp = {
      -- netrw must stay off so yazi.nvim (open_for_directories) handles
      -- `nvim <dir>` instead.
      disabled_plugins = { "netrwPlugin" },
    },
  },
})
