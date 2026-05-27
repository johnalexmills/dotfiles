return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewFileHistory" },
  keys = {
    { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diff View (working tree)" },
    { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File History" },
    { "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "Repo History" },
    { "<leader>gx", "<cmd>DiffviewClose<cr>", desc = "Close Diff View" },
    -- Merge conflict accept (only in diff mode buffers)
    {
      "gcl",
      function()
        if vim.wo.diff then
          vim.cmd "diffget 1"
        end
      end,
      desc = "Accept LOCAL",
      mode = "n",
    },
    {
      "gcb",
      function()
        if vim.wo.diff then
          vim.cmd "diffget 2"
        end
      end,
      desc = "Accept BASE",
      mode = "n",
    },
    {
      "gcr",
      function()
        if vim.wo.diff then
          vim.cmd "diffget 3"
        end
      end,
      desc = "Accept REMOTE",
      mode = "n",
    },
    {
      "gca",
      function()
        if vim.wo.diff then
          vim.cmd "diffget 1 | diffget 3"
        end
      end,
      desc = "Accept both LOCAL + REMOTE",
      mode = "n",
    },
  },
  opts = {
    enhanced_diff_hl = true,
    view = {
      default = {
        layout = "diff2_horizontal",
      },
      merge_tool = {
        layout = "diff4_mixed",
        disable_diagnostics = true,
      },
    },
    file_panel = {
      listing_style = "tree",
      tree_options = {
        flatten_dirs = true,
        folder_statuses = "only_folded",
      },
      win_config = {
        position = "left",
        width = 35,
      },
    },
    hooks = {
      diff_buf_read = function(_bufnr)
        vim.opt_local.wrap = false
        vim.opt_local.list = false
        vim.opt_local.colorcolumn = ""
      end,
    },
  },
}
