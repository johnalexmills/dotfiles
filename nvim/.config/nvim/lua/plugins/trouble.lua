return {
  "folke/trouble.nvim",
  cmd = "Trouble",
  keys = {
    { "<leader>tt", "<cmd>Trouble diagnostics toggle<cr>", desc = "Toggle Trouble Diagnostics" },
    { "<leader>ts", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Toggle Trouble Symbols" },
    { "<leader>tq", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Toggle Trouble Buffer Diagnostics" },
    { "<leader>tL", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions / references" },
    { "<leader>tl", "<cmd>Trouble loclist toggle<cr>", desc = "Location List" },
    { "<leader>tQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List" },
  },
  config = function()
    require("trouble").setup {}
  end,
}
