return {
  "MeanderingProgrammer/render-markdown.nvim",
  event = "VeryLazy",
  ft = { "markdown", "Avante", "avante" },
  opts = {
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
    bullet = {
      enabled = true,
      icons = { "●", "○", "◆", "◇" },
    },
  },
}
