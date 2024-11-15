return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",         -- required
    "sindrets/diffview.nvim",        -- optional - Diff integration


    -- Only one of these is needed.
    "nvim-telescope/telescope.nvim", -- optional
  },
    event = { "InsertEnter", "BufReadPre", "BufAdd", "BufNew", "BufReadPost" },
  config = function()
    require('lualine').setup {}
    end
}

