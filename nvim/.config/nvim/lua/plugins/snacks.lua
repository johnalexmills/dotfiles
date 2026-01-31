return {
  "folke/snacks.nvim",
  priority = 1000,
  event = "VeryLazy",
  keys = {
    {
      "<leader>T",
      function()
        Snacks.terminal(nil, { win = { position = "float" } })
      end,
      desc = "Float Terminal",
    },
    {
      "<C-\\>",
      function()
        Snacks.terminal()
      end,
      desc = "Toggle Terminal",
      mode = { "n", "t" },
    },
    {
      "<leader>gg",
      function()
        Snacks.terminal("lazygit", { cwd = Snacks.git.get_root() })
      end,
      desc = "LazyGit",
    },
    {
      "<leader>x",
      function()
        Snacks.bufdelete()
      end,
      desc = "Close Buffer",
    },
  },
  opts = {
    input = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    terminal = { enabled = true },
    indent = { enabled = true },
  },
}
