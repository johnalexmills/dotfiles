return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim", -- required
    "sindrets/diffview.nvim", -- optional - Diff integration

    -- Only one of these is needed.
    "nvim-telescope/telescope.nvim", -- optional
  },
<<<<<<< ours
  lazy = false,
=======
    event = { "InsertEnter", "BufReadPre", "BufAdd", "BufNew", "BufReadPost" },
>>>>>>> theirs
  config = function()
        require("neogit").setup{
            auto_close_console = false,
            integrations = {
                telescope = true,
                diffview = true
            }
        }
    end
}
