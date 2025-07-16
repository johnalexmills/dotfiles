return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
  event = "VeryLazy",
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup()

    vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Harpoon: Mark File" })
    vim.keymap.set("n", "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Toggle Harpoon Menu" })

    vim.keymap.set("n", "<C-n>", function() harpoon:list():select(1) end, { desc = "Harpoon File 1" })
    vim.keymap.set("n", "<C-e>", function() harpoon:list():select(2) end, { desc = "Harpoon File 2" })
    vim.keymap.set("n", "<C-i>", function() harpoon:list():select(3) end, { desc = "Harpoon File 3" })
    vim.keymap.set("n", "<C-o>", function() harpoon:list():select(4) end, { desc = "Harpoon File 4" })

  end,
}
