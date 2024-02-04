return {
  "lewis6991/gitsigns.nvim",
  event = "BufReadPre",
  config = function()
    require("gitsigns").setup {
      signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
      current_line_blame = true,
    }
  end,
}
