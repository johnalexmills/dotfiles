-- Quick close for special buffers
-- Allows "q" to close quickfix, help, man, LSP info, and spectre panels
-- Also hides these buffers from the buffer list
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "qf", "help", "man", "lspinfo", "spectre_panel" },
  callback = function()
    vim.cmd [[
      nnoremap <silent> <buffer> q :close<CR>
      set nobuflisted
    ]]
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
