-- This config requires Neovim 0.11+. Several features used here (function-form
-- vim.lsp.config, vim.hl.on_yank, vim.diagnostic.jump, jumpoptions = "stack",
-- the nvim-treesitter `main` branch API) were introduced in 0.10/0.11.
if vim.fn.has "nvim-0.11" == 0 then
  vim.notify("This config requires Neovim 0.11 or newer.", vim.log.levels.ERROR)
end

require "options"
require "keymaps"
require "Lazy"
require "autocommands"
