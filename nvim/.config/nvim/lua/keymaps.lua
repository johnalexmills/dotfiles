-- Shorten function name
local keymap = vim.keymap.set

--Remap space as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Normal --
keymap("n", "<C-h>", "<C-w>h", { noremap = true, silent = true, desc = "Move to left window" })
keymap("n", "<C-j>", "<C-w>j", { noremap = true, silent = true, desc = "Move to lower window" })
keymap("n", "<C-k>", "<C-w>k", { noremap = true, silent = true, desc = "Move to upper window" })
keymap("n", "<C-l>", "<C-w>l", { noremap = true, silent = true, desc = "Move to right window" })

-- Buffer navigation with Tab
keymap("n", "<Tab>", "<cmd>bnext<CR>", { noremap = true, silent = true, desc = "Next buffer" })
keymap("n", "<S-Tab>", "<cmd>bprevious<CR>", { noremap = true, silent = true, desc = "Previous buffer" })

-- Buffer management
keymap("n", "<leader>bo", "<cmd>%bd|e#|bd#<CR>", { desc = "Close others", noremap = true, silent = true })

-- Resize with Alt+hjkl
keymap("n", "<A-h>", "<cmd>vertical resize -2<CR>", { noremap = true, silent = true, desc = "Shrink window width" })
keymap("n", "<A-j>", "<cmd>resize +2<CR>", { noremap = true, silent = true, desc = "Grow window height" })
keymap("n", "<A-k>", "<cmd>resize -2<CR>", { noremap = true, silent = true, desc = "Shrink window height" })
keymap("n", "<A-l>", "<cmd>vertical resize +2<CR>", { noremap = true, silent = true, desc = "Grow window width" })

-- Better paste (Primeagen's "greatest remap ever")
-- Paste without losing clipboard content
keymap("v", "p", [["_dP]], { noremap = true, silent = true, desc = "Paste without overwriting register" })

-- Delete to black hole register (doesn't overwrite clipboard)
keymap({ "n", "v" }, "<leader>D", [["_d]], { noremap = true, silent = true, desc = "Delete to black hole register" })

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", { noremap = true, silent = true, desc = "Indent left and reselect" })
keymap("v", ">", ">gv", { noremap = true, silent = true, desc = "Indent right and reselect" })

-- Move blocks with indent
keymap("v", "J", "<cmd>m '>+1<CR>gv=gv", { noremap = true, silent = true, desc = "Move block down" })
keymap("v", "K", "<cmd>m '<-2<CR>gv=gv", { noremap = true, silent = true, desc = "Move block up" })

-- Better line joining
keymap("n", "J", "mzJ`z", { noremap = true, silent = true, desc = "Join lines (keep cursor)" })

-- Clear search highlight with Escape
keymap("n", "<Esc>", "<cmd>nohlsearch<CR>", { noremap = true, silent = true, desc = "Clear search highlight" })

-- Keep cursor centered during navigation
keymap("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true, desc = "Scroll down (centered)" })
keymap("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true, desc = "Scroll up (centered)" })
keymap("n", "n", "nzzzv", { noremap = true, silent = true, desc = "Next search result (centered)" })
keymap("n", "N", "Nzzzv", { noremap = true, silent = true, desc = "Prev search result (centered)" })

-- Commenting handled by Neovim 0.10+ native gc/gcc

-- Keymaps that must be available immediately (not deferred to VeryLazy via which-key)
keymap("n", "<leader>fn", "<cmd>enew<cr>", { noremap = true, silent = true, desc = "New File" })
keymap("n", "<leader>/", function()
  if vim.v.hlsearch == 1 then
    vim.cmd "nohlsearch"
  else
    vim.cmd "set hlsearch"
  end
end, { noremap = true, silent = true, desc = "Toggle Search Highlight" })
keymap("n", "<leader>r", function()
  vim.opt.relativenumber = not vim.opt.relativenumber:get()
end, { noremap = true, silent = true, desc = "Toggle Relative Numbers" })

local mappings = {
  -- File group
  { "<leader>f", group = "File", nowait = true, remap = false },

  -- Harpoon group
  { "<leader>h", group = "Harpoon", nowait = true, remap = false },
  { "<leader>fn", desc = "New File", nowait = true, remap = false },

  -- Buffer group
  { "<leader>b", group = "Buffer", nowait = true, remap = false },

  -- Git group
  { "<leader>g", group = "Git", nowait = true, remap = false },

  -- LSP group
  { "<leader>l", group = "LSP", nowait = true, remap = false },

  -- Trouble group
  { "<leader>t", group = "Trouble", nowait = true, remap = false },

  -- Search group
  { "<leader>s", group = "Search", nowait = true, remap = false },

  -- Session group
  { "<leader>S", group = "Session", nowait = true, remap = false },

  { "<leader>/", desc = "Toggle Search Highlight", nowait = true, remap = false },
  { "<leader>r", desc = "Toggle Relative Numbers", nowait = true, remap = false },
}
return mappings
