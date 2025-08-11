return {
  "MeanderingProgrammer/render-markdown.nvim",
  event = "VeryLazy",
  config = function()
    require("render-markdown").setup {
      file_types = { "markdown", "copilot-chat" },
      code = {
        sign = false,
        width = "block",
        right_pad = 1,
      },
      heading = {
        sign = false,
        icons = { "◉ ", "○ ", "✸ ", "✿ " },
      },
    }
  end,
}
