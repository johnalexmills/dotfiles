return {
  "jiaoshijie/undotree",
  dependencies = "nvim-lua/plenary.nvim",
  event = { "InsertEnter", "BufReadPre", "BufAdd", "BufNew", "BufReadPost" },
  config = true,
  keys = { -- load the plugin only when using it's keybinding:
    { "<leader>u", "<cmd>lua require('undotree').toggle()<cr>" },
  },
}
