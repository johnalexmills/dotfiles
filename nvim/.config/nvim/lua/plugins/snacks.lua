return {
  "folke/snacks.nvim",
  lazy = false,
  priority = 900,
  keys = {
    {
      "<C-\\>",
      function()
        Snacks.terminal(nil, { win = { position = "float" } })
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
      "<leader>c",
      function()
        Snacks.bufdelete()
      end,
      desc = "Close Buffer",
    },
    {
      "<leader>fr",
      function()
        Snacks.rename.rename_file()
      end,
      desc = "Rename File",
    },
    {
      "<leader>z",
      function()
        Snacks.zen()
      end,
      desc = "Toggle Zen Mode",
    },
  },
  opts = {
    input = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    terminal = { enabled = true },
    rename = { enabled = true },
    zen = { enabled = true },
    indent = {
      enabled = true,
      -- scope hl defined in colorscheme.lua using Catppuccin Mocha lavender
      scope = {
        hl = "SnacksIndentScope",
      },
    },
  },
}
