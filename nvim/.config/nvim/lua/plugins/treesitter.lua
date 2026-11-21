-- Using the rewritten `main` branch of nvim-treesitter, which requires
-- Neovim 0.11+.
--
-- IMPORTANT: unlike the legacy `master` branch, the `main` branch does NOT
-- enable anything for you. Neovim's runtime only calls vim.treesitter.start()
-- from a handful of bundled ftplugins (help, lua, markdown, query), so every
-- other language needs the FileType autocommand below or it silently falls
-- back to regex `syntax` highlighting.
--
-- Highlighting, folding and indentation are therefore all wired up here.
-- The legacy `nvim-treesitter-textobjects` integration is not used; install it
-- separately if you want text-object motions.

-- Parsers to install. Note these are *language* names, which do not always
-- match filetype names (e.g. the `bash` parser serves the `sh` filetype).
-- The autocommand below resolves filetype -> language automatically.
local parsers = {
  "lua",
  "python",
  "bash",
  "markdown",
  "markdown_inline",
  "json",
  "terraform",
  "hcl",
  "vim",
  "vimdoc",
  "query",
  "regex",
  "comment",
  "html",
  "css",
  "toml",
  "yaml",
  "dockerfile",
  "sql",
  "gdscript",
  "javascript",
  "typescript",
  "tsx",
  "ruby",
}

-- Skip treesitter on files above this size (bytes) to keep large-file editing
-- responsive.
local max_filesize = 100 * 1024

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  lazy = false, -- the main branch does not support lazy-loading (see README)
  config = function()
    require("nvim-treesitter").install(parsers)

    local augroup = vim.api.nvim_create_augroup("UserTreesitter", { clear = true })

    local function enable_treesitter(buf)
      -- Bail on very large files.
      local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return false
      end

      -- Resolve filetype -> parser language. get_lang() falls back to the
      -- filetype itself when there is no explicit mapping.
      local lang = vim.treesitter.language.get_lang(vim.bo[buf].filetype)
      if not lang then
        return false
      end

      -- language.add() returns true when a parser is available (including
      -- parsers bundled with Neovim) and nil + error otherwise. It does not
      -- throw, so this is a safe availability check.
      if not vim.treesitter.language.add(lang) then
        return false
      end

      vim.treesitter.start(buf, lang)

      -- Treesitter indentation is still marked experimental upstream.
      vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      return true
    end

    local function set_folds_for_win(win)
      if not win or not vim.api.nvim_win_is_valid(win) then
        return
      end
      local buf = vim.api.nvim_win_get_buf(win)
      if enable_treesitter(buf) then
        vim.wo[win][0].foldmethod = "expr"
        vim.wo[win][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
      end
    end

    vim.api.nvim_create_autocmd("FileType", {
      group = augroup,
      desc = "Enable treesitter highlighting, folds and indent",
      callback = function(args)
        enable_treesitter(args.buf)
      end,
    })

    vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
      group = augroup,
      desc = "Apply treesitter folds when displaying buffer",
      callback = function()
        set_folds_for_win(vim.api.nvim_get_current_win())
      end,
    })
  end,
}
