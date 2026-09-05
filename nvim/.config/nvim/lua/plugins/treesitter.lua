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
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("nvim-treesitter").install(parsers)

    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("UserTreesitter", { clear = true }),
      desc = "Enable treesitter highlighting, folds and indent",
      callback = function(args)
        local buf = args.buf

        -- Bail on very large files.
        local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
          return
        end

        -- Resolve filetype -> parser language. get_lang() falls back to the
        -- filetype itself when there is no explicit mapping.
        local lang = vim.treesitter.language.get_lang(vim.bo[buf].filetype)
        if not lang then
          return
        end

        -- language.add() returns true when a parser is available (including
        -- parsers bundled with Neovim) and nil + error otherwise. It does not
        -- throw, so this is a safe availability check.
        if not vim.treesitter.language.add(lang) then
          return
        end

        vim.treesitter.start(buf, lang)

        -- Treesitter indentation is still marked experimental upstream.
        vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

        -- Folds are window-local, so only set them when this buffer is
        -- actually displayed in the current window.
        if vim.api.nvim_get_current_buf() == buf then
          vim.wo[0][0].foldmethod = "expr"
          vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
        end
      end,
    })
  end,
}
