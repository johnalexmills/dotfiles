-- NOTE: the <C-n>/<C-e>/<C-i>/<C-o>/<C-'> file slots below are a deliberate
-- trade-off. <C-o> and <C-i> are Neovim's jumplist back/forward, and <C-i> is
-- indistinguishable from <Tab> (mapped to :bnext) on terminals that do not
-- implement the kitty keyboard protocol. Ghostty does implement it; over a
-- plain TTY or an old tmux, <C-i> will fall back to being <Tab>.
-- 'jumpoptions' is intentionally left at its default in options.lua as a result.
return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    {
      "<leader>ha",
      function()
        require("harpoon"):list():add()
      end,
      desc = "Add file",
    },
    {
      "<leader>hh",
      function()
        local harpoon = require "harpoon"
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
      desc = "Toggle menu",
    },
    {
      "<C-n>",
      function()
        require("harpoon"):list():select(1)
      end,
      desc = "Harpoon file 1",
    },
    {
      "<C-e>",
      function()
        require("harpoon"):list():select(2)
      end,
      desc = "Harpoon file 2",
    },
    {
      "<C-i>",
      function()
        require("harpoon"):list():select(3)
      end,
      desc = "Harpoon file 3",
    },
    {
      "<C-o>",
      function()
        require("harpoon"):list():select(4)
      end,
      desc = "Harpoon file 4",
    },
    {
      "<C-'>",
      function()
        require("harpoon"):list():select(5)
      end,
      desc = "Harpoon file 5",
    },
  },
  opts = {},
}
