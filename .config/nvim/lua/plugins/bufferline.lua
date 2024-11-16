return {
  "akinsho/bufferline.nvim",
    after = "catppuccin",
  dependencies = "nvim-tree/nvim-web-devicons",
  event = { "InsertEnter", "BufReadPre", "BufAdd", "BufNew", "BufReadPost" },
    config = function()
        require("bufferline").setup{
        highlights = require("catppuccin.groups.integrations.bufferline").get(),
    options = {
      separator_style = "slope",
      diagnostics = "nvim_lsp",
    },
        }
        end
}
