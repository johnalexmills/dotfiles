return {
  "mrjones2014/smart-splits.nvim",
  lazy = false,
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

    -- recommended mappings
    vim.keymap.set("n", "<A-h>", require("smart-splits").resize_left)
    vim.keymap.set("n", "<A-j>", require("smart-splits").resize_down)
    vim.keymap.set("n", "<A-k>", require("smart-splits").resize_up)
    vim.keymap.set("n", "<A-l>", require("smart-splits").resize_right)
    -- moving between splits
    vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left)
    vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down)
    vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up)
    vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right)
  end,
}
