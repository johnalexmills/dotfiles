local options = {
  backup = false, -- creates a backup file
  exrc = true, -- enable .exrc files
  hidden = true, -- enable modified buffers in background
  nu = true, -- enable line numbers
  undofile = true, -- enable persistent undo
  clipboard = "unnamedplus", -- allows neovim to access the system clipboard
  cmdheight = 1, -- more space in the neovim command line for displaying messages
  completeopt = { "menuone", "noselect" }, -- mostly just for cmp
  conceallevel = 0, -- so that `` is visible in markdown files
  fileencoding = "utf-8", -- the encoding written to a file
  hlsearch = true, -- highlight all matches on previous search pattern
  incsearch = true, -- show search matches incrementally
  ignorecase = true, -- ignore case in search patterns
  mouse = "a", -- allow the mouse to be used in neovim
  pumheight = 10, -- pop up menu height
  showmode = false, -- we don't need to see things like -- INSERT -- anymore
  showtabline = 0, -- never show tabs
  smartcase = true, -- smart case
  smartindent = true, -- make indenting smarter again
  splitbelow = true, -- force all horizontal splits to go below current window
  splitright = true, -- force all vertical splits to go to the right of current window
  swapfile = false, -- creates a swapfile
  termguicolors = true, -- set term gui colors (most terminals support this)
  scrolloff = 10, -- is one of my fav
  colorcolumn = "80", -- limit line length
  timeoutlen = 500, -- time to wait for a mapped sequence to complete (in milliseconds)
  linebreak = true,
  updatetime = 25, -- faster completion (4000ms default)
  writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  expandtab = true, -- convert tabs to spaces
  shiftwidth = 4, -- the number of spaces inserted for each indentation
  tabstop = 4, -- insert 2 spaces for a tab
  cursorline = true, -- highlight the current line
  number = true, -- set numbered lines
  relativenumber = true, -- set relative numbered lines
  numberwidth = 4, -- set number column width to 2 {default 4}
  signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
  wrap = false, -- display lines as one long line
  sidescrolloff = 8,
  foldmethod = "syntax",
  foldlevelstart = 99,
  guifont = "JetBrainsMono Nerd Font:h17",
  errorbells = false, -- no error bells
  -- guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175",
}
vim.opt.shortmess:append "c"
for k, v in pairs(options) do
  vim.opt[k] = v
end

if ConfigMode == "rich" then
  vim.opt.termguicolors = true
  vim.o.background = "dark"
  vim.opt.clipboard = "unnamedplus"
end

vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd [[set iskeyword+=-]]
vim.cmd [[set formatoptions-=cro]] -- TODO: this doesn't seem to work

if package.config:sub(1, 1) == "\\" then
  vim.cmd ":set shell=cmd.exe"
end
vim.opt.formatoptions:remove { "c", "r", "o" } -- This is a sequence of letters which describes how automatic formatting is to be done

-- checks OS and sets terminal accordingly. Needed for Windows since gitbash is used.
if vim.fn.has "win32" ~= 0 then
  vim.o.shell = "bash.exe"
  vim.o.shellcmdflag = "-c"
  vim.o.shellredir = ">%s 2>&1"
  vim.o.shellquote = ""
  vim.o.shellxescape = ""
  -- vim.o.noshelltemp = true
  vim.o.shellxquote = ""
  vim.o.shellpipe = "2>&1| tee"
  vim.env.TMP = "/tmp"
end
