return {
  "MeanderingProgrammer/render-markdown.nvim",
  event = "VeryLazy",
  config = function()
    require("render-markdown").setup {
      file_types = { "markdown", "Avante", "avante" },
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
