return {
  "folke/trouble.nvim",
  event = "BufEnter",
  cmd = "Trouble",
  config = function()
    require("trouble").setup {}
  end,
}
