return {
  "mrjones2014/smart-splits.nvim",
  keys = {
    { "<A-h>", function() require("smart-splits").resize_left() end, desc = "Resize split left" },
    { "<A-j>", function() require("smart-splits").resize_down() end, desc = "Resize split down" },
    { "<A-k>", function() require("smart-splits").resize_up() end, desc = "Resize split up" },
    { "<A-l>", function() require("smart-splits").resize_right() end, desc = "Resize split right" },
    { "<C-h>", function() require("smart-splits").move_cursor_left() end, desc = "Move cursor left" },
    { "<C-j>", function() require("smart-splits").move_cursor_down() end, desc = "Move cursor down" },
    { "<C-k>", function() require("smart-splits").move_cursor_up() end, desc = "Move cursor up" },
    { "<C-l>", function() require("smart-splits").move_cursor_right() end, desc = "Move cursor right" },
  },
  config = function()
    require("smart-splits").setup({
      ignored_events = {
        "BufEnter",
        "WinEnter",
      },
      ignored_filetypes = { "nofile", "quickfix", "qf", "prompt" },
      ignored_buftypes = { "nofile" },
      default_amount = 3,
      at_edge = "wrap",
      float_win_behavior = "previous",
      move_cursor_same_row = false,
      cursor_follows_swapped_bufs = false,
      resize_mode = {
        quit_key = "<ESC>",
        resize_keys = { "h", "j", "k", "l" },
        silent = false,
        hooks = {
          on_enter = nil,
          on_leave = nil,
        },
      },
      multiplexer_integration = nil,
      disable_multiplexer_nav_when_zoomed = true,
    })
  end,
}
