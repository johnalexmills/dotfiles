return {
  "j-hui/fidget.nvim",
  event = "LspAttach",
  opts = {
    progress = {
      display = {
        done_ttl = 5,
        done_icon = "✔",
        progress_ttl = 8,
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
      view = {
        stack_upwards = true,
        icon_separator = " ",
        group_separator = "---",
        group_separator_hl = "Comment",
      },
      configs = {
        default = vim.tbl_extend("force", require("fidget.notification").default_config, {
          name = "Fidget",
          icon = "🔔",
          ttl = 10, -- Keep notifications longer
          render = function(notif)
            return string.format("[%s] %s", notif.name or "LSP", notif.message)
          end,
        }),
      },
    },
  },
}
