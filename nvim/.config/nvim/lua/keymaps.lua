-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { noremap = true, silent = true }

--Source nvim config changes
vim.keymap.set("n", "<leader>so", ":update<CR> :source<CR>")

--Remap space as leader key
keymap("n", "<Space>", "", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Normal --
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with Alt+hjkl
keymap("n", "<A-h>", ":vertical resize -2<CR>", opts)
keymap("n", "<A-j>", ":resize +2<CR>", opts)
keymap("n", "<A-k>", ":resize -2<CR>", opts)
keymap("n", "<A-l>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<Tab>", ":bnext<CR>", opts)
keymap("n", "<S-Tab>", ":bprevious<CR>", opts)

-- Better paste
keymap("v", "p", "P", opts)
keymap("x", "<leader>p", '"_dP', opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move blocks with indent
keymap("v", "J", ":m '>+1<CR>gv=gv")
keymap("v", "K", ":m '<-2<CR>gv=gv")

-- Comment handled by mini.comment plugin (gcc, gc)

local mappings = {
  -- Plugin groups (for which-key display)
  { "<leader>f", desc = "Find Files", nowait = true, remap = false },
  { "<leader>F", desc = "Find Text", nowait = true, remap = false },
  { "<leader>b", desc = "Buffers", nowait = true, remap = false },
  { "<leader>g", group = "Git", nowait = true, remap = false },
  { "<leader>l", group = "LSP", nowait = true, remap = false },
  { "<leader>s", group = "Search", nowait = true, remap = false },
  { "<leader>t", group = "Terminal/Trouble", nowait = true, remap = false },
  { "<leader>d", group = "Diff", nowait = true, remap = false },

  -- Tree view commands
  { "<leader>T", group = "Tree View", nowait = true, remap = false },
  {
    "<leader>Tt",
    function()
      local output = vim.fn.systemlist "tree"
      local buf = vim.api.nvim_create_buf(false, true)
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, output)
      vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
      vim.api.nvim_buf_set_option(buf, "filetype", "text")
      vim.api.nvim_win_set_buf(0, buf)
    end,
    desc = "Show File Tree",
    nowait = true,
    remap = false,
  },
  {
    "<leader>Ta",
    function()
      local output = vim.fn.systemlist "tree -a -I '.git'"
      local buf = vim.api.nvim_create_buf(false, true)
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, output)
      vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
      vim.api.nvim_buf_set_option(buf, "filetype", "text")
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

  { "<leader>h", group = "Harpoon", nowait = true, remap = false },
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
      vim.opt.relativenumber = not vim.opt.relativenumber:get() and true or false
    end,
    desc = "Toggle Relative Numbers",
    nowait = true,
    remap = false,
  },
  { "<leader>q", "<cmd>q!<CR>", desc = "Quit", nowait = true, remap = false },
  { "<leader>w", "<cmd>w!<CR>", desc = "Save", nowait = true, remap = false },
  { "<leader>x", "<cmd>Bdelete!<CR>", desc = "Close Buffer", nowait = true, remap = false },
}
return mappings
