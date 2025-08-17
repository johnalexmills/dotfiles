return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
  keys = {
    { "<leader>ha", function() require("harpoon"):list():add() end, desc = "Harpoon: Mark File" },
    { "<leader>hh", function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end, desc = "Toggle Harpoon Menu" },
    { "<leader>hr", function() require("harpoon"):list():remove() end, desc = "Harpoon: Remove File" },
    { "<leader>hc", function() require("harpoon"):list():clear() end, desc = "Harpoon: Clear List" },
    { "<M-n>", function() require("harpoon"):list():select(1) end, desc = "Harpoon File 1" },
    { "<M-e>", function() require("harpoon"):list():select(2) end, desc = "Harpoon File 2" },
    { "<M-i>", function() require("harpoon"):list():select(3) end, desc = "Harpoon File 3" },
    { "<M-o>", function() require("harpoon"):list():select(4) end, desc = "Harpoon File 4" },
  },
  opts = {},
}
