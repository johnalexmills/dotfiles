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

-- CodeCompanion visual mode keymap
keymap("v", "<leader>aa", "<cmd>CodeCompanionAdd<cr>", { desc = "Add to CodeCompanion", noremap = true, silent = true })

-- Comment handled by mini.comment plugin (gcc, gc)

local mappings = {
  { "<leader>a", group = "AI Assistant", nowait = true, remap = false },
  { "<leader>aA", "<cmd>CodeCompanionActions<cr>", desc = "CodeCompanion Actions", nowait = true, remap = false },
  { "<leader>ac", "<cmd>CodeCompanion<cr>", desc = "CodeCompanion Chat", nowait = true, remap = false },
  {
    "<leader>at",
    "<cmd>CodeCompanionChat Toggle<cr>",
    desc = "Toggle CodeCompanion Chat",
    nowait = true,
    remap = false,
  },
  { "<leader>ai", "<cmd>CodeCompanionInline<cr>", desc = "CodeCompanion Inline", nowait = true, remap = false },
  { "<leader>f", "<cmd>Telescope find_files<cr>", desc = "Find Files", nowait = true, remap = false },
  { "<leader>F", "<cmd>Telescope live_grep<cr>", desc = "Find Text", nowait = true, remap = false },
  { "<leader>b", "<cmd>Telescope buffers<cr>", desc = "Buffers", nowait = true, remap = false },

  { "-", "<CMD>Oil<CR>", desc = "Explorer", nowait = true, remap = false },

  { "<leader>g", group = "Git", nowait = true, remap = false },
  { "<leader>gg", "<cmd>lua _lazygit_toggle()<CR>", desc = "LazyGit", nowait = true, remap = false },
  { "<leader>h", group = "Harpoon", nowait = true, remap = false },
  { "<leader>l", group = "LSP", nowait = true, remap = false },
  {
    "<leader>lD",
    "<cmd>Telescope diagnostics bufnr=0<cr>",
    desc = "Document Diagnostics",
    nowait = true,
    remap = false,
  },
  { "<leader>lI", "<cmd>Mason<cr>", desc = "Mason Installer", nowait = true, remap = false },
  { "<leader>lL", "<cmd>lua vim.lsp.codelens.run()<cr>", desc = "CodeLens Action", nowait = true, remap = false },
  {
    "<leader>lS",
    "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
    desc = "Workspace Symbols",
    nowait = true,
    remap = false,
  },
  { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Action", nowait = true, remap = false },
  { "<leader>lf", "<cmd>lua require'conform'.format()<cr>", desc = "Format", nowait = true, remap = false },
  { "<leader>li", "<cmd>LspInfo<cr>", desc = "Info", nowait = true, remap = false },
  {
    "<leader>lj",
    "<cmd>lua vim.diagnostic.goto_next()<CR>",
    desc = "Next Diagnostic",
    nowait = true,
    remap = false,
  },
  {
    "<leader>lk",
    "<cmd>lua vim.diagnostic.goto_prev()<cr>",
    desc = "Prev Diagnostic",
    nowait = true,
    remap = false,
  },
  { "<leader>ll", "<cmd>lua require('lint').try_lint()<cr>", desc = "Lint", nowait = true, remap = false },
  { "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<cr>", desc = "Quickfix", nowait = true, remap = false },
  { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename", nowait = true, remap = false },
  { "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols", nowait = true, remap = false },
  { "<leader>lw", "<cmd>Telescope diagnostics<cr>", desc = "Workspace Diagnostics", nowait = true, remap = false },
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
    "<leader>rn",
    function()
      vim.opt.relativenumber = not vim.opt.relativenumber:get() and true or false
    end,
    desc = "Toggle Relative Numbers",
    nowait = true,
    remap = false,
  },
  { "<leader>q", "<cmd>q!<CR>", desc = "Quit", nowait = true, remap = false },
  { "<leader>s", group = "Search", nowait = true, remap = false },
  { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands", nowait = true, remap = false },
  { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages", nowait = true, remap = false },
  { "<leader>sR", "<cmd>Telescope registers<cr>", desc = "Registers", nowait = true, remap = false },
  { "<leader>sb", "<cmd>Telescope git_branches<cr>", desc = "Checkout branch", nowait = true, remap = false },
  { "<leader>sc", "<cmd>Telescope colorscheme<cr>", desc = "Colorscheme", nowait = true, remap = false },
  { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Find Help", nowait = true, remap = false },
  { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps", nowait = true, remap = false },
  { "<leader>sr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files", nowait = true, remap = false },

  { "<leader>sf", "<cmd>Telescope file_browser<cr>", desc = "File Browser", nowait = true, remap = false },
  { "<leader>w", "<cmd>w!<CR>", desc = "Save", nowait = true, remap = false },
  { "<leader>x", "<cmd>Bdelete!<CR>", desc = "Close Buffer", nowait = true, remap = false },

  { "<leader>t", group = "Terminal/Trouble", nowait = true, remap = false },
  -- Terminal keymaps
  { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Float Terminal", nowait = true, remap = false },
  {
    "<leader>tv",
    "<cmd>ToggleTerm direction=vertical size=80<cr>",
    desc = "Vertical Terminal",
    nowait = true,
    remap = false,
  },
  {
    "<leader>th",
    "<cmd>ToggleTerm direction=horizontal size=15<cr>",
    desc = "Horizontal Terminal",
    nowait = true,
    remap = false,
  },
  -- Trouble keymaps
  {
    "<leader>tt",
    "<cmd>Trouble diagnostics toggle<cr>",
    desc = "Toggle Trouble Diagnostics",
    nowait = true,
    remap = false,
  },
  {
    "<leader>ts",
    "<cmd>Trouble symbols toggle focus=false<cr>",
    desc = "Toggle Trouble Symbols",
    nowait = true,
    remap = false,
  },
  {
    "<leader>tq",
    "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
    desc = "Toggle Trouble Buffer Diagnostics",
    nowait = true,
    remap = false,
  },
  {
    "<leader>tL",
    "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
    desc = "LSP Definitions / references",
    nowait = true,
    remap = false,
  },
  { "<leader>tl", "<cmd>Trouble loclist toggle<cr>", desc = "Location List", nowait = true, remap = false },
  { "<leader>tQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List", nowait = true, remap = false },
}
return mappings
