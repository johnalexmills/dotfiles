-- Quick close for special buffers
-- Allows "q" to close quickfix, help, man, LSP info, and spectre panels
-- Also hides these buffers from the buffer list
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "qf", "help", "man", "lspinfo" },
  callback = function(event)
    vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = event.buf, silent = true })
    vim.bo[event.buf].buflisted = false
  end,
})

-- Enable wrapping and spell check for text-based file types
-- Applies to: git commits, markdown, plain text, LaTeX, emails, reStructuredText, AsciiDoc, and Org files
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "gitcommit", "markdown", "text", "tex", "mail", "rst", "asciidoc", "org" },
  callback = function()
    vim.opt_local.wrap = true        -- Enable line wrapping for readability
    vim.opt_local.spell = true       -- Enable spell checking
  end,
})

-- Start in insert mode for git commits
vim.api.nvim_create_autocmd("FileType", {
  pattern = "gitcommit",
  callback = function()
    vim.cmd "startinsert!"
  end,
})

-- Automatically resize splits when terminal is resized
-- Ensures all window splits are equal size after resizing the terminal
vim.api.nvim_create_autocmd({ "VimResized" }, {
  callback = function()
    vim.cmd "tabdo wincmd ="  -- Execute "wincmd =" (equalize windows) in all tabs
  end,
})

-- Briefly highlight yanked text
-- Provides visual feedback when you yank (copy) text
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  callback = function()
    vim.highlight.on_yank { higroup = "Visual", timeout = 200 }  -- Highlight for 200ms using Visual highlight group
  end,
})

-- Automatically remove trailing whitespace before saving
-- Skips files larger than 100 KB for performance reasons
vim.api.nvim_create_autocmd("BufWritePre", {
  desc = "Remove trailing whitespace",
  callback = function()
    -- Skip for large files (performance)
    local max_filesize = 100 * 1024 -- 100 KB
    local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(0))
    if ok and stats and stats.size > max_filesize then
      return
    end

    -- Save cursor position, remove trailing whitespace, then restore cursor
    local save_cursor = vim.fn.getpos "."
    vim.cmd [[%s/\s\+$//e]]  -- Substitute trailing whitespace with nothing (e flag = no error if not found)
    vim.fn.setpos(".", save_cursor)
  end,
})

-- Automatically create parent directories when saving a file
-- If you save to a path like "foo/bar/baz.txt" and "foo/bar/" doesn't exist, it will be created
vim.api.nvim_create_autocmd("BufWritePre", {
  desc = "Auto-create parent directories",
  callback = function(event)
    -- Skip URIs (like oil://, http://, etc.)
    if event.match:match "^%w%w+://" then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")  -- Create directory with "p" flag (like mkdir -p)
  end,
})

-- Return to last cursor position when reopening a file
-- Uses the " mark which stores the last position before exiting
vim.api.nvim_create_autocmd("BufReadPost", {
  desc = "Return to last cursor position",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')  -- Get the " mark (last position)
    local lcount = vim.api.nvim_buf_line_count(0)
    -- Only restore if the mark is valid and within the file's line count
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Check if file changed externally and reload if needed
-- Triggers when: gaining focus, entering a buffer, or cursor is idle
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  desc = "Check if file changed externally",
  callback = function()
    if vim.fn.mode() ~= "c" then  -- Don't check in command-line mode
      pcall(vim.cmd, "checktime")  -- Check if any buffers changed on disk
    end
  end,
})

-- Automatically save all modified buffers when losing focus
-- Only saves if the buffer has a filename, is modified, and is not readonly
vim.api.nvim_create_autocmd("FocusLost", {
  desc = "Auto-save on focus lost",
  callback = function()
    if vim.bo.modified and not vim.bo.readonly and vim.fn.expand "%" ~= "" then
      vim.cmd "silent! wall"  -- Write all modified buffers (silent = don't show messages)
    end
  end,
})

-- Per-filetype colorcolumn
-- Prose/text formats get no ruler; code files get language-appropriate limits
vim.api.nvim_create_autocmd("FileType", {
  desc = "Set colorcolumn per filetype",
  callback = function()
    local ft = vim.bo.filetype
    local col = ({
      -- Prose — no column ruler
      markdown  = "",
      text      = "",
      tex       = "",
      rst       = "",
      asciidoc  = "",
      org       = "",
      gitcommit = "72",   -- git commit subject line convention
      -- Web / config — 100 cols
      html      = "100",
      css       = "100",
      scss      = "100",
      json      = "100",
      yaml      = "100",
      toml      = "100",
      -- Systems / scripting — 100 cols
      lua       = "100",
      bash      = "100",
      sh        = "100",
      fish      = "100",
      vim       = "100",
      -- Python — PEP 8 recommends 79, Black uses 88
      python    = "88",
      -- Terraform / HCL — 100 cols
      terraform = "100",
      hcl       = "100",
      -- SQL — 100 cols
      sql       = "100",
      -- GDScript — 100 cols
      gdscript  = "100",
    })[ft]
    -- Default for unlisted filetypes
    if col == nil then col = "100" end
    vim.opt_local.colorcolumn = col
  end,
})

-- Per-filetype: remove "o", "c", "r" from formatoptions for code files
-- "o" stops o/O from auto-inserting a comment leader
-- "c" stops auto-wrapping comments using textwidth
-- "r" stops auto-inserting comment leader after Enter
-- Must be done in a FileType autocmd because ftplugins reset formatoptions
local code_filetypes = {
  "lua", "python", "bash", "sh", "fish", "vim",
  "html", "css", "scss", "json", "yaml", "toml",
  "terraform", "hcl", "sql", "gdscript",
  "javascript", "typescript", "tsx", "jsx",
  "c", "cpp", "rust", "go", "java", "ruby",
}
vim.api.nvim_create_autocmd("FileType", {
  pattern = code_filetypes,
  desc = "Remove 'o', 'c', 'r' from formatoptions for code filetypes",
  callback = function()
    vim.opt_local.formatoptions:remove { "o", "c", "r" }
  end,
})

-- Per-filetype: treat hyphen as part of a keyword only for web filetypes
-- Prevents hyphen-as-keyword from breaking word motions in other languages
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "html", "css", "scss", "javascript", "typescript", "tsx", "jsx" },
  desc = "Treat hyphen as keyword character for web filetypes",
  callback = function()
    vim.opt_local.iskeyword:append "-"
  end,
})
