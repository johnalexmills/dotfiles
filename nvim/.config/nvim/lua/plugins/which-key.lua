return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {},
  config = function(_, opts)
    local wk = require "which-key"
    wk.setup(opts)
    wk.add {
      -- Group definitions
      { "<leader>f", group = "File", nowait = true, remap = false },
      { "<leader>h", group = "Harpoon", nowait = true, remap = false },
      { "<leader>b", group = "Buffer", nowait = true, remap = false },
      { "<leader>g", group = "Git", nowait = true, remap = false },
      { "<leader>l", group = "LSP", nowait = true, remap = false },
      { "<leader>t", group = "Trouble", nowait = true, remap = false },
      { "<leader>s", group = "Search", nowait = true, remap = false },
      { "<leader>S", group = "Session", nowait = true, remap = false },
      { "<leader>n", group = "Neotest", nowait = true, remap = false },
      { "<leader>q", group = "Persistence", nowait = true, remap = false },
    }
  end,
}
