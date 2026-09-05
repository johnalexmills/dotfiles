return {
  "folke/persistence.nvim",
  event = "VeryLazy",
  opts = {},
  -- All session mappings live here under <leader>S. They used to be split
  -- across this file (<leader>q*) and plugins/snacks.lua (<leader>S*), which
  -- gave one plugin two key prefixes and two which-key groups.
  keys = {
    {
      "<leader>Sr",
      function()
        require("persistence").load()
      end,
      desc = "Restore Session (cwd)",
    },
    {
      "<leader>Sl",
      function()
        require("persistence").load { last = true }
      end,
      desc = "Restore Last Session",
    },
    {
      "<leader>SS",
      function()
        require("persistence").select()
      end,
      desc = "Select Session",
    },
    {
      "<leader>Ss",
      function()
        require("persistence").save()
      end,
      desc = "Save Session",
    },
    {
      "<leader>Sd",
      function()
        require("persistence").stop()
      end,
      desc = "Stop Session (don't save on exit)",
    },
  },
}
