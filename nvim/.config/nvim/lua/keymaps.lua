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

-- Buffer navigation with Tab
keymap("n", "<Tab>", ":bnext<CR>", opts)
keymap("n", "<S-Tab>", ":bprevious<CR>", opts)

-- Buffer management
keymap("n", "<leader>ba", ":%bd|e#<CR>", { desc = "Close all but current", noremap = true, silent = true })
keymap("n", "<leader>bo", ":%bd|e#|bd#<CR>", { desc = "Close others", noremap = true, silent = true })

-- Window management
keymap("n", "<leader>w", "<C-w>", { desc = "Window commands", noremap = true, silent = true })

-- Resize with Alt+hjkl
keymap("n", "<A-h>", ":vertical resize -2<CR>", opts)
keymap("n", "<A-j>", ":resize +2<CR>", opts)
keymap("n", "<A-k>", ":resize -2<CR>", opts)
keymap("n", "<A-l>", ":vertical resize +2<CR>", opts)

-- Better paste (Primeagen's "greatest remap ever")
-- Paste without losing clipboard content
keymap("x", "<leader>p", [["_dP]], opts)
keymap("v", "p", [["_dP]], opts)

-- Delete to black hole register (doesn't overwrite clipboard)
keymap({ "n", "v" }, "<leader>D", [["_d]], opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move blocks with indent
keymap("v", "J", ":m '>+1<CR>gv=gv")
keymap("v", "K", ":m '<-2<CR>gv=gv")

-- Better line joining
keymap("n", "J", "mzJ`z", opts)

-- Keep cursor centered during navigation
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

-- Comment handled by mini.comment plugin (gcc, gc)

local mappings = {
  -- Buffer group
  { "<leader>b", group = "Buffer", nowait = true, remap = false },

  -- Git group
  { "<leader>g", group = "Git", nowait = true, remap = false },

  -- LSP group
  { "<leader>l", group = "LSP", nowait = true, remap = false },

  -- Telescope group
  { "<leader>t", group = "Telescope", nowait = true, remap = false },
  { "<leader>tv", group = "Vim", nowait = true, remap = false },

  -- Other groups
  { "<leader>d", group = "Diff", nowait = true, remap = false },
  { "<leader>h", group = "Harpoon", nowait = true, remap = false },
  { "<leader>m", group = "Markdown", nowait = true, remap = false },
  { "<leader>w", group = "Window", nowait = true, remap = false },

  -- Terminal group
  { "<leader>T", group = "Terminal", nowait = true, remap = false },
  { "<leader>Tt", group = "Tree View", nowait = true, remap = false },
  -- Tree view commands
  {
    "<leader>Ttt",
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
      vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
      vim.api.nvim_buf_set_option(buf, "filetype", "text")
      vim.api.nvim_win_set_buf(0, buf)
    end,
    desc = "Show File Tree",
    nowait = true,
    remap = false,
  },
  {
    "<leader>Tta",
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
      vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
      vim.api.nvim_buf_set_option(buf, "filetype", "text")
      vim.api.nvim_win_set_buf(0, buf)
    end,
    desc = "Show Tree (Hidden)",
    nowait = true,
    remap = false,
  },
  {
    "<leader>Ttd",
    "<cmd>terminal fd --type d --max-depth 3<cr>",
    desc = "Show Directories",
    nowait = true,
    remap = false,
  },
  {
    "<leader>Ttx",
    function()
      local debug_info = {
        "=== DEBUG INFORMATION ===",
        "OS: " .. (vim.fn.has "win32" == 1 and "Windows" or "Unix"),
        "Working directory: " .. vim.fn.getcwd(),
        "Shell: " .. vim.o.shell,
        "",
        "=== EXECUTABLE TESTS ===",
        "tree executable: " .. (vim.fn.executable "tree" == 1 and "YES" or "NO"),
        "bash executable: " .. (vim.fn.executable "bash" == 1 and "YES" or "NO"),
        "cmd executable: " .. (vim.fn.executable "cmd" == 1 and "YES" or "NO"),
        "",
        "=== TESTING COMMANDS ===",
      }

      -- Test different commands
      local commands = {
        "tree",
        "bash -c tree",
        "cmd /c tree",
        "cmd /c dir",
        "where tree",
        "bash -c 'which tree'",
      }

      for _, cmd in ipairs(commands) do
        local output = vim.fn.systemlist(cmd)
        local exit_code = vim.v.shell_error
        table.insert(debug_info, "")
        table.insert(debug_info, "Command: " .. cmd)
        table.insert(debug_info, "Exit code: " .. exit_code)
        table.insert(debug_info, "Output lines: " .. #output)
        if #output > 0 then
          table.insert(debug_info, "First line: " .. (output[1] or ""))
          if #output > 1 then
            table.insert(debug_info, "Second line: " .. (output[2] or ""))
          end
        end
      end

      local buf = vim.api.nvim_create_buf(false, true)
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, debug_info)
      vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
      vim.api.nvim_buf_set_option(buf, "filetype", "text")
      vim.api.nvim_win_set_buf(0, buf)
    end,
    desc = "Debug Tree Commands",
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
  { "<leader>x", "<cmd>Bdelete!<CR>", desc = "Close Buffer", nowait = true, remap = false },
  { "<leader>u", "<cmd>UndotreeToggle<CR>", desc = "Toggle Undotree", nowait = true, remap = false },

  -- Todo Comments group
  { "<leader>td", group = "Todo Comments", nowait = true, remap = false },
  { "<leader>tdt", "<cmd>TodoTelescope<CR>", desc = "Search Todos", nowait = true, remap = false },
  { "<leader>tdl", "<cmd>TodoLocList<CR>", desc = "Todo Location List", nowait = true, remap = false },
  { "<leader>tdq", "<cmd>TodoQuickFix<CR>", desc = "Todo QuickFix", nowait = true, remap = false },
}
return mappings
