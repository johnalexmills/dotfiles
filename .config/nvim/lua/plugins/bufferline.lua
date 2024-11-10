return {
  "akinsho/bufferline.nvim",
  event = { "InsertEnter", "BufReadPre", "BufAdd", "BufNew", "BufReadPost" },
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  require("bufferline").setup {
    options = {
      separator_style = "slant",
    },
  },
}
