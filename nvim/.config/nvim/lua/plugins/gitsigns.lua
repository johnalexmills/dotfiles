return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  cond = function()
    return vim.bo.filetype ~= "oil"
  end,
  opts = {
    signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
    current_line_blame = true, -- Disable by default for performance
    current_line_blame_opts = {
      delay = 300, -- Add delay if enabled manually
    },
  },
}
