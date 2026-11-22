-- Quick close for special buffers
-- Allows "q" to close quickfix, help and man windows (checkhealth buffers
-- already map q themselves). Also hides these buffers from the buffer list.
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "qf", "help", "man" },
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
    vim.opt_local.wrap = true -- Enable line wrapping for readability
    vim.opt_local.spell = true -- Enable spell checking
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
    vim.cmd "tabdo wincmd =" -- Execute "wincmd =" (equalize windows) in all tabs
  end,
})

-- Briefly highlight yanked text
-- Provides visual feedback when you yank (copy) text
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  callback = function()
    vim.hl.on_yank { higroup = "Visual", timeout = 200 } -- Highlight for 200ms using Visual highlight group
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
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p") -- Create directory with "p" flag (like mkdir -p)
  end,
})

-- Return to last cursor position when reopening a file
-- Uses the " mark which stores the last position before exiting
vim.api.nvim_create_autocmd("BufReadPost", {
  desc = "Return to last cursor position",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"') -- Get the " mark (last position)
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
    if vim.fn.mode() ~= "c" then -- Don't check in command-line mode
      pcall(vim.cmd, "checktime") -- Check if any buffers changed on disk
    end
  end,
})

-- Note: auto-save on FocusLost was removed. Session auto-save on exit is
-- handled by persistence.nvim, which registers its own VimLeavePre autocmd
-- (see plugins/persistence.lua). Snacks has no session module.

-- Per-filetype colorcolumn and formatoptions
-- Prose gets no ruler and keeps its formatoptions. Everything else is treated
-- as code: a ruler at 100 (88 for Python, the Black/ruff default; 72 for
-- commit messages) and no auto comment leaders or comment wrapping
-- ("o", "r", "c"). Done in a FileType autocmd because ftplugins reset
-- formatoptions.
local prose = { markdown = true, text = true, tex = true, rst = true, asciidoc = true, org = true, mail = true }
local colorcolumn = { python = "88", gitcommit = "72" }
vim.api.nvim_create_autocmd("FileType", {
  desc = "Set colorcolumn and formatoptions per filetype",
  callback = function(event)
    local ft = event.match
    if prose[ft] then
      vim.opt_local.colorcolumn = ""
      return
    end
    vim.opt_local.colorcolumn = colorcolumn[ft] or "100"
    if ft ~= "gitcommit" then
      vim.opt_local.formatoptions:remove { "o", "c", "r" }
    end
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
