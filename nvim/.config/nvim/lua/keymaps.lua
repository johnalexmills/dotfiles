-- Core keymaps that must be available immediately at startup (not deferred to
-- VeryLazy via which-key). which-key descriptions / groups live in
-- plugins/which-key.lua.
--
-- Note: vim.keymap.set defaults to noremap = true since Neovim 0.7, so we omit it.

local map = vim.keymap.set

-- Leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Window navigation
map("n", "<C-h>", "<C-w>h", { silent = true, desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { silent = true, desc = "Move to lower window" })
map("n", "<C-k>", "<C-w>k", { silent = true, desc = "Move to upper window" })
map("n", "<C-l>", "<C-w>l", { silent = true, desc = "Move to right window" })

-- Buffer navigation with Tab
map("n", "<Tab>", "<cmd>bnext<CR>", { silent = true, desc = "Next buffer" })
map("n", "<S-Tab>", "<cmd>bprevious<CR>", { silent = true, desc = "Previous buffer" })

-- Buffer management
map("n", "<leader>bo", "<cmd>%bd|e#|bd#<CR>", { silent = true, desc = "Close others" })

-- Resize with Alt+hjkl
map("n", "<A-h>", "<cmd>vertical resize -2<CR>", { silent = true, desc = "Shrink window width" })
map("n", "<A-j>", "<cmd>resize +2<CR>", { silent = true, desc = "Grow window height" })
map("n", "<A-k>", "<cmd>resize -2<CR>", { silent = true, desc = "Shrink window height" })
map("n", "<A-l>", "<cmd>vertical resize +2<CR>", { silent = true, desc = "Grow window width" })

-- Better paste (Primeagen's "greatest remap ever")
-- Paste without losing clipboard content
map("v", "p", [["_dP]], { silent = true, desc = "Paste without overwriting register" })

-- Delete to black hole register (doesn't overwrite clipboard)
map({ "n", "v" }, "<leader>D", [["_d]], { silent = true, desc = "Delete to black hole register" })

-- Stay in indent mode
map("v", "<", "<gv", { silent = true, desc = "Indent left and reselect" })
map("v", ">", ">gv", { silent = true, desc = "Indent right and reselect" })

-- Move blocks with indent
map("v", "J", "<cmd>m '>+1<CR>gv=gv", { silent = true, desc = "Move block down" })
map("v", "K", "<cmd>m '<-2<CR>gv=gv", { silent = true, desc = "Move block up" })

-- Better line joining
map("n", "J", "mzJ`z", { silent = true, desc = "Join lines (keep cursor)" })

-- Clear search highlight with Escape
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { silent = true, desc = "Clear search highlight" })

-- Keep cursor centered during navigation
map("n", "<C-d>", "<C-d>zz", { silent = true, desc = "Scroll down (centered)" })
map("n", "<C-u>", "<C-u>zz", { silent = true, desc = "Scroll up (centered)" })
map("n", "n", "nzzzv", { silent = true, desc = "Next search result (centered)" })
map("n", "N", "Nzzzv", { silent = true, desc = "Prev search result (centered)" })

-- Commenting handled by Neovim 0.10+ native gc/gcc

-- New file
map("n", "<leader>fn", "<cmd>enew<cr>", { silent = true, desc = "New File" })

-- Toggle search highlight
map("n", "<leader>/", function()
  if vim.v.hlsearch == 1 then
    vim.cmd "nohlsearch"
  else
    vim.cmd "set hlsearch"
  end
end, { silent = true, desc = "Toggle Search Highlight" })

-- Toggle relative line numbers
map("n", "<leader>r", function()
  vim.opt.relativenumber = not vim.wo.relativenumber
end, { silent = true, desc = "Toggle Relative Numbers" })
