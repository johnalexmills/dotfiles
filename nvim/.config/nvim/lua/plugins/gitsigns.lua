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
    -- next_hunk / prev_hunk are deprecated in favour of nav_hunk(direction).
    -- ]c and [c are also Neovim's built-in diff-mode motions, so fall back to
    -- those when the window is in diff mode (:diffsplit, diffview, ...).
    {
      "]c",
      function()
        if vim.wo.diff then
          vim.cmd.normal { "]c", bang = true }
        else
          require("gitsigns").nav_hunk "next"
        end
      end,
      desc = "Next git hunk",
    },
    {
      "[c",
      function()
        if vim.wo.diff then
          vim.cmd.normal { "[c", bang = true }
        else
          require("gitsigns").nav_hunk "prev"
        end
      end,
      desc = "Previous git hunk",
    },
    -- Note: gitsigns v1.0+ uses space-separated subcommand syntax
    { "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "Toggle git blame line" },
    { "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", desc = "Preview hunk" },
    -- stage_hunk now toggles (acts as both stage and unstage); undo_stage_hunk removed in v1.0
    { "<leader>gS", "<cmd>Gitsigns stage_hunk<cr>", desc = "Stage / unstage hunk (toggle)" },
    { "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>", desc = "Reset hunk" },
    { "<leader>gi", "<cmd>Gitsigns diffthis<cr>", desc = "Diff this (inline)" },
  },
}
