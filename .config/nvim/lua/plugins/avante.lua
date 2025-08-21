return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false,
    cmd = { "AvanteAsk", "AvanteChat", "AvanteToggle", "AvanteRefresh" },
    build = vim.fn.has("win32") == 1 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" or "make",
    dependencies = {
      "folke/snacks.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante", "avante" },
        },
        ft = { "markdown", "Avante", "avante" },
      },
    },
    opts = {
      provider = "copilot",
      providers = {
        claude = {
          endpoint = "https://api.anthropic.com",
          model = "claude-sonnet-4",
          extra_request_body = {
            temperature = 0.1,
            max_tokens = 4096,
          },
        },
        copilot = {
          endpoint = "https://api.githubcopilot.com",
          model = "claude-sonnet-4",
          timeout = 30000,
        },
      },
      behaviour = {
        auto_suggestions = false,
      },

      windows = {
        width = 45,
      },
    },
  },
}
