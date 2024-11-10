return {
  "akinsho/bufferline.nvim",
  dependencies = "nvim-tree/nvim-web-devicons",
  event = { "InsertEnter", "BufReadPre", "BufAdd", "BufNew", "BufReadPost" },
  config = function()
    require("bufferline").setup {
      options = {
        separator_style = "slope",
        diagnostics = "nvim_lsp",
      },
    }
  end,
}
