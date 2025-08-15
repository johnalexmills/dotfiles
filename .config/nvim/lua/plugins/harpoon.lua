return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
  event = "VeryLazy",
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup()

    vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, { desc = "Harpoon: Mark File" })
    vim.keymap.set("n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Toggle Harpoon Menu" })
    vim.keymap.set("n", "<leader>hr", function() harpoon:list():remove() end, { desc = "Harpoon: Remove File" })
    vim.keymap.set("n", "<leader>hc", function() harpoon:list():clear() end, { desc = "Harpoon: Clear List" })

    vim.keymap.set("n", "<M-n>", function() harpoon:list():select(1) end, { desc = "Harpoon File 1" })
    vim.keymap.set("n", "<M-e>", function() harpoon:list():select(2) end, { desc = "Harpoon File 2" })
    vim.keymap.set("n", "<M-i>", function() harpoon:list():select(3) end, { desc = "Harpoon File 3" })
    vim.keymap.set("n", "<M-o>", function() harpoon:list():select(4) end, { desc = "Harpoon File 4" })

  end,
}
