-- Disable built-in plugins for better performance
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_netrwFileHandlers = 1

-- Disable unused providers
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python_provider = 0

-- Disable built-in plugins you don't use
vim.g.loaded_gzip = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_spellfile_plugin = 1

local options = {
  backup = false, -- creates a backup file
  exrc = true, -- enable .exrc files
  nu = true, -- enable line numbers
  undofile = true, -- enable persistent undo
  clipboard = "unnamedplus", -- allows neovim to access the system clipboard
  cmdheight = 1, -- more space in the neovim command line for displaying messages
  completeopt = { "menuone", "noselect" }, -- mostly just for cmp
  conceallevel = 0, -- so that `` is visible in markdown files
  fileencoding = "utf-8", -- the encoding written to a file
  hlsearch = true, -- highlight all matches on previous search pattern
  incsearch = true, -- show search matches incrementally
  wrapscan = true, -- searches wrap around the end of the file
  ignorecase = true, -- ignore case in search patterns
  mouse = "a", -- allow the mouse to be used in neovim
  pumheight = 10, -- pop up menu height
  showmode = false, -- we don't need to see things like -- INSERT -- anymore
  showtabline = 0, -- always show tabline for buffers
  smartcase = true, -- smart case
  smartindent = true, -- make indenting smarter again
  splitbelow = true, -- force all horizontal splits to go below current window
  splitright = true, -- force all vertical splits to go to the right of current window
  swapfile = false, -- creates a swapfile
  termguicolors = true, -- set term gui colors (most terminals support this)
  scrolloff = 10, -- is one of my fav
  colorcolumn = "80", -- limit line length
  timeoutlen = 500, -- time to wait for a mapped sequence to complete (better UX)
  linebreak = true,
  updatetime = 250, -- faster completion (4000ms default)
  writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  expandtab = true, -- convert tabs to spaces
  shiftwidth = 4, -- the number of spaces inserted for each indentation
  tabstop = 4, -- insert 2 spaces for a tab
  cursorline = true, -- highlight the current line
  number = true, -- set numbered lines
  relativenumber = false, -- set relative numbered lines
  numberwidth = 4, -- set number column width to 2 {default 4}
  signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
  wrap = false, -- display lines as one long line
  sidescrolloff = 8,
  foldmethod = "expr",
  foldexpr = "nvim_treesitter#foldexpr()",
  foldtext = "",
  foldlevelstart = 99,
  ttimeoutlen = 10, -- faster key sequence timeout
  foldnestmax = 4,
  guifont = "CaskaydiaCove Nerd Font:h17:i",
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

if package.config:sub(1, 1) == "\\" then
  vim.cmd ":set shell=cmd.exe"
end
vim.opt.formatoptions:remove { "c", "r", "o" } -- This is a sequence of letters which describes how automatic formatting is to be done

-- Enhanced diagnostics
vim.diagnostic.config({
  virtual_text = false,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "✘",
      [vim.diagnostic.severity.WARN] = "▲",
      [vim.diagnostic.severity.HINT] = "⚑",
      [vim.diagnostic.severity.INFO] = "»",
    },
  },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})

-- checks OS and sets terminal accordingly. Needed for Windows since gitbash is used.
if vim.fn.has "win32" ~= 0 then
  vim.env.NODE_TLS_REJECT_UNAUTHORIZED = "0"
  vim.o.shell = "nu.exe"
  vim.o.shellcmdflag = "-c"
  vim.o.shellredir = ">%s 2>&1"
  vim.o.shellquote = ""
  vim.o.shellxescape = ""
  -- vim.o.noshelltemp = true
  vim.o.shellxquote = ""
  vim.o.shellpipe = "2>&1| tee"
  vim.env.TMP = "/tmp"
end
