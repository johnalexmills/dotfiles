return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    signcolumn = true,
    current_line_blame = false,
    current_line_blame_opts = {
      delay = 300,
    },
  },
  keys = {
    { "]c", "<cmd>Gitsigns next_hunk<cr>", desc = "Next git hunk" },
    { "[c", "<cmd>Gitsigns prev_hunk<cr>", desc = "Previous git hunk" },
    { "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "Toggle git blame line" },
    { "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", desc = "Preview hunk" },
    { "<leader>gS", "<cmd>Gitsigns stage_hunk<cr>", desc = "Stage hunk" },
    { "<leader>gu", "<cmd>Gitsigns undo_stage_hunk<cr>", desc = "Undo stage hunk" },
    { "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>", desc = "Reset hunk" },
    { "<leader>gd", "<cmd>Gitsigns diffthis<cr>", desc = "Diff this" },
  },
}
