-- Shorten function name
local keymap = vim.keymap.set

--Remap space as leader key
keymap("n", "<Space>", "", { noremap = true, silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Normal --
keymap("n", "<C-h>", "<C-w>h", { noremap = true, silent = true, desc = "Move to left window" })
keymap("n", "<C-j>", "<C-w>j", { noremap = true, silent = true, desc = "Move to lower window" })
keymap("n", "<C-k>", "<C-w>k", { noremap = true, silent = true, desc = "Move to upper window" })
keymap("n", "<C-l>", "<C-w>l", { noremap = true, silent = true, desc = "Move to right window" })

-- Buffer navigation with Tab
keymap("n", "<Tab>", ":bnext<CR>", { noremap = true, silent = true, desc = "Next buffer" })
keymap("n", "<S-Tab>", ":bprevious<CR>", { noremap = true, silent = true, desc = "Previous buffer" })

-- Buffer management
keymap("n", "<leader>bo", ":%bd|e#|bd#<CR>", { desc = "Close others", noremap = true, silent = true })

-- Resize with Alt+hjkl
keymap("n", "<A-h>", ":vertical resize -2<CR>", { noremap = true, silent = true, desc = "Shrink window width" })
keymap("n", "<A-j>", ":resize +2<CR>", { noremap = true, silent = true, desc = "Grow window height" })
keymap("n", "<A-k>", ":resize -2<CR>", { noremap = true, silent = true, desc = "Shrink window height" })
keymap("n", "<A-l>", ":vertical resize +2<CR>", { noremap = true, silent = true, desc = "Grow window width" })

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
keymap("v", "J", ":m '>+1<CR>gv=gv", { noremap = true, silent = true, desc = "Move block down" })
keymap("v", "K", ":m '<-2<CR>gv=gv", { noremap = true, silent = true, desc = "Move block up" })

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

local mappings = {
  -- File group
  { "<leader>f", group = "File", nowait = true, remap = false },

  -- Harpoon group
  { "<leader>h", group = "Harpoon", nowait = true, remap = false },
  {
    "<leader>fn",
    "<cmd>enew<cr>",
    desc = "New File",
    nowait = true,
    remap = false,
  },

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

  -- Terminal group
  { "<leader>T", group = "Tree View", nowait = true, remap = false },
  -- Tree view commands
  {
    "<leader>Tt",
    function()
      local cmd = 'tree -I ".git|.terraform|.terragrunt-cache|node_modules"'
      if vim.fn.has "win32" == 1 then
        cmd = "tree -I .git,.terraform,.terragrunt-cache,node_modules"
      end

      local output = vim.fn.systemlist(cmd)
      -- Remove carriage return characters on Windows
      if vim.fn.has "win32" == 1 then
        for i, line in ipairs(output) do
          output[i] = line:gsub("\r", "")
        end
      end

      local buf = vim.api.nvim_create_buf(false, true)
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, output)
      vim.bo[buf].buftype = "nofile"
      vim.bo[buf].filetype = "text"
      vim.api.nvim_win_set_buf(0, buf)
    end,
    desc = "Show File Tree",
    nowait = true,
    remap = false,
  },
  {
    "<leader>Ta",
    function()
      local cmd = 'tree -a -I ".git|.terraform|.terragrunt-cache|node_modules"'
      if vim.fn.has "win32" == 1 then
        cmd = "tree -a -I .git,.terraform,.terragrunt-cache,node_modules"
      end

      local output = vim.fn.systemlist(cmd)
      -- Remove carriage return characters on Windows
      if vim.fn.has "win32" == 1 then
        for i, line in ipairs(output) do
          output[i] = line:gsub("\r", "")
        end
      end

      local buf = vim.api.nvim_create_buf(false, true)
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, output)
      vim.bo[buf].buftype = "nofile"
      vim.bo[buf].filetype = "text"
      vim.api.nvim_win_set_buf(0, buf)
    end,
    desc = "Show Tree (Hidden)",
    nowait = true,
    remap = false,
  },
  {
    "<leader>Td",
    "<cmd>terminal fd --type d --max-depth 3<cr>",
    desc = "Show Directories",
    nowait = true,
    remap = false,
  },

  {
    "<leader>/",
    function()
      if vim.v.hlsearch == 1 then
        vim.cmd "nohlsearch"
      else
        vim.cmd "set hlsearch"
      end
    end,
    desc = "Toggle Search Highlight",
    nowait = true,
    remap = false,
  },
  {
    "<leader>r",
    function()
      vim.opt.relativenumber = not vim.opt.relativenumber:get()
    end,
    desc = "Toggle Relative Numbers",
    nowait = true,
    remap = false,
  },
}
return mappings
