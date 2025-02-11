return {
  "Exafunction/codeium.nvim",
  cmd = "Codeium",
  event = { "BufEnter" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
  },
  config = function()
    require("codeium").setup {
            enable_chat = true,
            virtual_text = {
                enabled = true
            }
        }
  end,
}
