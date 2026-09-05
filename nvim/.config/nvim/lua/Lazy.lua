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
  debug = false,
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
        "rplugin",
        "spellfile",
        -- NOTE: do not disable "man". Snacks' man picker (<leader>sm) opens
        -- results with :Man, and autocommands.lua binds q in man buffers.
        -- NOTE: "health" is not a runtime plugin in Neovim 0.12 (:checkhealth
        -- is built in), so listing it here did nothing.
      },
    },
  },
})
