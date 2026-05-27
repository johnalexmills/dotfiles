return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewFileHistory" },
  keys = {
    { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diff View (working tree)" },
    { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File History" },
    { "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "Repo History" },
    { "<leader>gx", "<cmd>DiffviewClose<cr>", desc = "Close Diff View" },
  },
  opts = {
    enhanced_diff_hl = true,
    view = {
      default = {
        layout = "diff2_horizontal",
      },
      merge_tool = {
        -- 3-way merge layout: LOCAL | BASE | REMOTE on top, RESULT on bottom
        layout = "diff3_horizontal",
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
      -- Disable diagnostics and word wrap in diff buffers for clarity
      diff_buf_read = function(_bufnr)
        vim.opt_local.wrap = false
        vim.opt_local.list = false
        vim.opt_local.colorcolumn = ""
        -- Merge conflict quick-accept keymaps (buffer-local)
        vim.keymap.set("n", "gcl", function()
          vim.cmd "diffget 1"
        end, { buffer = true, desc = "Accept LOCAL" })
        vim.keymap.set("n", "gcb", function()
          vim.cmd "diffget 2"
        end, { buffer = true, desc = "Accept BASE" })
        vim.keymap.set("n", "gcr", function()
          vim.cmd "diffget 3"
        end, { buffer = true, desc = "Accept REMOTE" })
        vim.keymap.set("n", "gca", function()
          vim.cmd "diffget 1 | diffget 3"
        end, { buffer = true, desc = "Accept both LOCAL + REMOTE" })
      end,
    },
  },
}
