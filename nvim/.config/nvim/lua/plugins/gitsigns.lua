return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    signcolumn = true,
    attach_to_untracked = false,
    current_line_blame = false,
    current_line_blame_opts = {
      delay = 300,
    },
  },
  keys = {
    { "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "Toggle git blame line" },
  },
}
