-- This config requires Neovim 0.11+. Features used here that were introduced in
-- 0.10/0.11: vim.lsp.config / vim.lsp.enable, client:supports_method(),
-- vim.hl.on_yank, vim.diagnostic.jump, vim.wo[win][buf], jumpoptions = "stack",
-- and the nvim-treesitter `main` branch API.
if vim.fn.has "nvim-0.11" == 0 then
  vim.notify("This config requires Neovim 0.11 or newer.", vim.log.levels.ERROR)
end

require "options"
require "keymaps"
require "Lazy"
require "autocommands"
