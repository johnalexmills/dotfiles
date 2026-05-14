-- Using the rewritten `main` branch of nvim-treesitter, which requires
-- Neovim 0.11+. Highlighting is driven by Neovim's built-in `vim.treesitter.start()`
-- (called automatically by ftplugins). The legacy `master` branch's
-- `nvim-treesitter-textobjects` integration is not used here; if you want
-- text-object motions, install treesitter-textobjects separately.
return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  lazy = false,
  config = function()
    -- Install parsers (main branch API)
    require("nvim-treesitter").install {
      "lua",
      "python",
      "bash",
      "markdown",
      "markdown_inline",
      "json",
      "terraform",
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

    -- Highlighting is handled by Neovim's built-in vim.treesitter.start()
    -- which is called automatically via ftplugins. To disable it for large
    -- files, use an autocommand:
    vim.api.nvim_create_autocmd("BufReadPre", {
      callback = function(args)
        local max_filesize = 100 * 1024
        local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(args.buf))
        if ok and stats and stats.size > max_filesize then
          vim.treesitter.stop(args.buf)
        end
      end,
    })
  end,
}
