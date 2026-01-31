-- Disable built-in plugins for better performance
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_netrwFileHandlers = 1

-- Disable unused providers (keep python3 for potential plugins)
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
  -- File Backups and History
  backup = false,                          -- Don't create backup files before overwriting
  undofile = true,                         -- Save undo history to a file for persistence across sessions
  swapfile = false,                        -- Don't create swap files (backup in case of crash)
  writebackup = false,                     -- Don't create backup before overwriting a file
  confirm = true,                          -- Prompt to save instead of failing on :q with unsaved changes

  -- Project-Specific Configuration
  exrc = true,                             -- Enable reading .nvimrc/.exrc in project directories

  -- Line Numbers
  number = true,                           -- Show absolute line numbers
  relativenumber = false,                  -- Don't show relative line numbers
  numberwidth = 4,                         -- Width of the line number column

  -- System Integration
  clipboard = "unnamedplus",               -- Use system clipboard for yank/paste operations
  mouse = "a",                             -- Enable mouse support in all modes

  -- Command Line and UI
  cmdheight = 1,                           -- Height of the command line area
  showmode = false,                        -- Don't show mode (e.g., -- INSERT --) since it's in statusline
  showtabline = 0,                         -- Never show the tabline (bufferline plugin handles this)
  pumheight = 10,                          -- Maximum number of items in popup menu (completion)

  -- Completion Settings
  completeopt = { "menu", "menuone", "noselect" }, -- Show menu even for single match, don't auto-select

  -- Encoding
  fileencoding = "utf-8",                  -- File encoding for writing files

  -- Search Settings
  hlsearch = true,                         -- Highlight all search matches
  incsearch = true,                        -- Show matches while typing search pattern
  inccommand = "split",                    -- Show live preview of :s command in split window (Neovim 0.9+)
  wrapscan = true,                         -- Search wraps around end of file
  ignorecase = true,                       -- Ignore case in search patterns
  smartcase = true,                        -- Override ignorecase if search contains uppercase

  -- Indentation
  smartindent = true,                      -- Smart autoindenting for C-like languages
  autoindent = true,                       -- Copy indent from current line to new line
  expandtab = true,                        -- Convert tabs to spaces
  shiftwidth = 4,                          -- Number of spaces for each indentation level
  tabstop = 4,                             -- Number of spaces that a tab counts for

  -- Window Splitting
  splitbelow = true,                       -- Horizontal splits open below current window
  splitright = true,                       -- Vertical splits open to the right of current window
  splitkeep = "screen",                    -- Keep screen position when splitting (Neovim 0.9+)

  -- Colors and Display
  termguicolors = true,                    -- Enable 24-bit RGB colors in the terminal
  conceallevel = 0,                        -- Don't hide any characters (e.g., `` in markdown)
  cursorline = true,                       -- Highlight the current line
  cursorlineopt = "number",                -- Only highlight the line number, not the whole line
  colorcolumn = "80",                      -- Show a vertical line at column 80

  -- Scrolling
  scrolloff = 10,                          -- Keep 10 lines visible above/below cursor when scrolling
  sidescrolloff = 8,                       -- Keep 8 columns visible left/right of cursor when scrolling
  jumpoptions = "stack",                   -- Make jumplist behave like a stack (Neovim 0.11+)

  -- Text Wrapping
  wrap = false,                            -- Don't wrap long lines visually
  linebreak = true,                        -- If wrap is enabled, break at word boundaries
  breakindent = true,                      -- Wrapped lines maintain visual indent
  smoothscroll = true,                     -- Smoother scrolling for wrapped lines (Neovim 0.10+)

  -- Timing
  timeoutlen = 500,                        -- Time in ms to wait for mapped sequence to complete
  ttimeoutlen = 50,                        -- Time in ms to wait for key code sequence to complete
  updatetime = 250,                        -- Time in ms before swap file is written (also affects CursorHold)

  -- Folding (using treesitter for syntax-aware folds)
  foldmethod = "expr",                     -- Use expression for folding
  foldexpr = "v:lua.vim.treesitter.foldexpr()", -- Treesitter-based folding
  foldlevelstart = 99,                     -- Start with all folds open
  foldnestmax = 4,                         -- Maximum nesting of folds

  -- Editing
  virtualedit = "block",                   -- Allow cursor past end of line in visual block mode

  -- GUI Settings
  guifont = "CaskaydiaCove Nerd Font:h17:i", -- Font for GUI versions of neovim

  -- Performance and Redrawing
  errorbells = false,                      -- No beeping on errors
  lazyredraw = false,                      -- Redraw screen during macros (can cause plugin issues if true)
  redrawtime = 1500,                       -- Time in ms for redrawing the display

  -- Sign Column
  signcolumn = "yes",                      -- Always show sign column (for LSP, git signs, etc.)

  -- Diff Mode
  diffopt = "internal,filler,closeoff,hiddenoff,algorithm:minimal", -- Better diff display options

  -- Wildmenu (Command-line Completion)
  wildmode = "longest:full,full",          -- Complete longest common string, then show full matches
  wildignore = "*.o,*.obj,*~,*.exe,*.a,*.pdb,*.lib,*.so,*.dll,*.swp,.DS_Store,*.jpg,*.png,*.xpm,*.gif,*.pdf,*.bmp,*.tar,*.zip,*.tgz", -- Files to ignore in completion

  -- Session Management
  sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions", -- What to save in sessions
}
-- Append 'c' to shortmess (don't show completion messages like "match 1 of 2")
vim.opt.shortmess:append "c"

-- Apply all options from the table above
for k, v in pairs(options) do
  vim.opt[k] = v
end

-- Rich mode configuration (if ConfigMode is set to "rich")
if ConfigMode == "rich" then
  vim.opt.termguicolors = true           -- Enable true color support
  vim.o.background = "dark"              -- Use dark background for colorschemes
  vim.opt.clipboard = "unnamedplus"      -- Ensure system clipboard is enabled
end

-- Allow specified keys to move to the previous/next line when at start/end of line
vim.opt.whichwrap:append "<>[]hl"

-- Treat hyphenated words as a single word object (e.g., for word motions)
vim.opt.iskeyword:append "-"

-- Remove auto-commenting on new lines (c=comments, r=insert mode Enter, o=normal mode o/O)
vim.opt.formatoptions:remove { "c", "r", "o" }

-- LSP Diagnostics Configuration
vim.diagnostic.config {
  virtual_text = false,                    -- Don't show diagnostic text inline (reduces clutter)
  signs = {                                -- Custom icons for diagnostic signs in the sign column
    text = {
      [vim.diagnostic.severity.ERROR] = "✘",  -- Error icon
      [vim.diagnostic.severity.WARN] = "▲",   -- Warning icon
      [vim.diagnostic.severity.HINT] = "⚑",   -- Hint icon
      [vim.diagnostic.severity.INFO] = "»",   -- Info icon
    },
  },
  underline = true,                        -- Underline diagnostic regions
  severity_sort = true,                    -- Sort diagnostics by severity
  float = {                                -- Floating window settings for diagnostic popups
    focusable = false,                     -- Can't focus the floating window
    style = "minimal",                     -- Minimal style (no line numbers, etc.)
    border = "rounded",                    -- Rounded border
    source = "always",                     -- Always show the source of the diagnostic
    header = "",                           -- No header text
    prefix = "",                           -- No prefix before diagnostic message
  },
}

-- Windows-specific configuration (use Git Bash)
if vim.fn.has "win32" ~= 0 then
  vim.env.NODE_TLS_REJECT_UNAUTHORIZED = "0"  -- Disable Node.js TLS cert verification
  -- Configure shell to use Git Bash for all shell operations
  vim.o.shell = "bash.exe"                    -- Use bash.exe as the shell
  vim.o.shellcmdflag = "-c"                   -- Flag to execute a command
  vim.o.shellredir = ">%s 2>&1"               -- Redirect stdout and stderr
  vim.o.shellquote = ""                       -- No quoting of the command
  vim.o.shellxescape = ""                     -- No special escaping
  vim.o.shellxquote = ""                      -- No extra quoting
  vim.o.shellpipe = "2>&1| tee"               -- Pipe command with tee
  vim.env.TMP = "/tmp"                        -- Set temp directory to Unix-style path
end
