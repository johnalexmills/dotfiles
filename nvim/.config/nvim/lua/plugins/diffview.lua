return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory", "DiffviewToggleFiles", "DiffviewRefresh" },
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>d", group = "Diff" },
    { "<leader>do", "<cmd>DiffviewOpen<cr>", desc = "Open Diff View" },
    { "<leader>dc", "<cmd>DiffviewClose<cr>", desc = "Close Diff View" },
    { "<leader>dh", "<cmd>DiffviewFileHistory<cr>", desc = "File History" },
    { "<leader>df", "<cmd>DiffviewToggleFiles<cr>", desc = "Toggle File Panel" },
    { "<leader>dr", "<cmd>DiffviewRefresh<cr>", desc = "Refresh Diff" },
  },
  opts = {
    enhanced_diff_hl = true,
    use_icons = true,
    file_panel = {
      listing_style = "tree",
      tree_options = {
        flatten_dirs = true,
        folder_statuses = "only_folded",
      },
    },
    file_history_panel = {
      log_options = {
        git = {
          single_file = {
            diff_merges = "combined",
          },
          multi_file = {
            diff_merges = "first-parent",
          },
        },
      },
    },
  },
}

