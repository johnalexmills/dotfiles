-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { noremap = true, silent = true }

--Remap space as leader key
keymap("n", "<Space>", "", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Normal --
-- Better window navigation (handled by smart-splits plugin)
-- keymap("n", "<C-h>", "<C-w>h", opts)
-- keymap("n", "<C-j>", "<C-w>j", opts)
-- keymap("n", "<C-k>", "<C-w>k", opts)
-- keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize +2<CR>", opts)

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

-- Comment
keymap("n", "<C-/>", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", opts)
keymap("x", "<C-/>", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", opts)

local mappings = {
  { "<leader>c", "<cmd>AvanteToggle<cr>", desc = "Avante Toggle", nowait = true, remap = false },
  { "<leader>C", "<cmd>Copilot enable<cr>", desc = "Copilot", nowait = true, remap = false },
  { "<leader>F", "<cmd>Telescope live_grep theme=ivy<cr>", desc = "Find Text", nowait = true, remap = false },
  -- { "<leader>a", "<cmd>Alpha<cr>", desc = "Alpha", nowait = true, remap = false },
  {
    "<leader>b",
    "<cmd>lua require('telescope.builtin').buffers()<cr>",
    desc = "Buffers",
    nowait = true,
    remap = false,
  },
  { "-", "<CMD>Oil<CR>", desc = "Explorer", nowait = true, remap = false },
  {
    "<leader>f",
    "<cmd>lua require('telescope.builtin').find_files()<cr>",
    desc = "Find files",
    nowait = true,
    remap = false,
  },
  { "<leader>g", group = "Git", nowait = true, remap = false },
  { "<leader>gd", desc = "Go to definition", nowait = true, remap = false },
  { "<leader>gr", desc = "Go to reference", nowait = true, remap = false },
  { "<leader>l", group = "LSP", nowait = true, remap = false },
  {
    "<leader>lD",
    "<cmd>Telescope diagnostics bufnr=0<cr>",
    desc = "Document Diagnostics",
    nowait = true,
    remap = false,
  },
  { "<leader>lI", "<cmd>LspInstallInfo<cr>", desc = "Installer Info", nowait = true, remap = false },
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
  { "<leader>n", "<cmd>nohlsearch<CR>", desc = "No Highlight", nowait = true, remap = false },
  { "<leader>/", function()
    if vim.v.hlsearch == 1 then
      vim.cmd("nohlsearch")
    else
      vim.cmd("set hlsearch")
    end
  end, desc = "Toggle Search Highlight", nowait = true, remap = false },
  { "<leader>q", "<cmd>q!<CR>", desc = "Quit", nowait = true, remap = false },
  { "<leader>s", group = "Search", nowait = true, remap = false },
  { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands", nowait = true, remap = false },
  { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages", nowait = true, remap = false },
  { "<leader>sR", "<cmd>Telescope registers<cr>", desc = "Registers", nowait = true, remap = false },
  { "<leader>sb", "<cmd>Telescope git_branches<cr>", desc = "Checkout branch", nowait = true, remap = false },
  { "<leader>sc", "<cmd>Telescope colorscheme<cr>", desc = "Colorscheme", nowait = true, remap = false },
  { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Find Help", nowait = true, remap = false },
  { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps", nowait = true, remap = false },
  { "<leader>sr", "<cmd>Telescope oldfiles<cr>", desc = "Open Recent File", nowait = true, remap = false },
  { "<leader>sf", "<cmd>Telescope file_browser<cr>", desc = "File Browser", nowait = true, remap = false },
  { "<leader>w", "<cmd>w!<CR>", desc = "Save", nowait = true, remap = false },
  { "<leader>x", "<cmd>Bdelete!<CR>", desc = "Close Buffer", nowait = true, remap = false },
  { "<leader>t", group = "Terminal/Trouble", nowait = true, remap = false },
  -- Terminal keymaps
  { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Float Terminal", nowait = true, remap = false },
  { "<leader>tv", "<cmd>ToggleTerm direction=vertical size=80<cr>", desc = "Vertical Terminal", nowait = true, remap = false },
  { "<leader>th", "<cmd>ToggleTerm direction=horizontal size=15<cr>", desc = "Horizontal Terminal", nowait = true, remap = false },
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
