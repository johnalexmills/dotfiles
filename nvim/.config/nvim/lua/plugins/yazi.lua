return {
  "mikavilpas/yazi.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    {
      "-",
      function()
        require("yazi").yazi()
      end,
      desc = "Explorer (yazi)",
    },
    {
      "<leader>-",
      function()
        require("yazi").yazi(nil, vim.fn.getcwd())
      end,
      desc = "Explorer CWD (yazi)",
    },
  },
  opts = {
    open_for_directories = true,
    keymaps = {
      show_help = "<f1>",
    },
    floating_window_scaling_factor = 0.9,
    yazi_floating_window_border = "rounded",
  },
}
