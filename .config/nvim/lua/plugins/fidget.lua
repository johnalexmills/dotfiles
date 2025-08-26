return {
  "j-hui/fidget.nvim",
  event = "LspAttach",
  opts = {
    progress = {
      display = {
        done_ttl = 3,
        done_icon = "✔",
        progress_ttl = 5,
        progress_icon = { pattern = "dots", period = 1 },
      },
    },
    notification = {
      window = {
        winblend = 0,
        border = "rounded",
        max_width = 50,
        relative = "editor",
        x_padding = 1,
        y_padding = 1,
      },
    },
  },
}
