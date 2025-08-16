return {
  "j-hui/fidget.nvim",
  event = "LspAttach",
  opts = {
    progress = {
      display = {
        done_ttl = 5,
        done_icon = "✔",
        progress_ttl = math.huge,
      },
    },
    notification = {
      window = {
        winblend = 0,
        border = "rounded",
        max_width = 50,
      },
    },
  },
}
