return {
  "j-hui/fidget.nvim",
  cmd = "Fidget",
  event = "LspAttach",
  config = function()
    require("fidget").setup({
      progress = {
        display = {
          render_limit = 16,
          done_ttl = 3,
          done_icon = "✔",
          done_style = "Constant",
          progress_icon = { pattern = "dots", period = 1 },
          progress_style = "WarningMsg",
          group_style = "Title",
          overrides = {
            rust_analyzer = { name = "rust-analyzer" },
          },
        },
      },
      notification = {
        window = {
          winblend = 100,
          border = "none",
          align = "bottom",
          relative = "editor",
        },
      },
    })
  end,
}
