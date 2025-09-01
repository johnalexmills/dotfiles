return {
  "rachartier/tiny-inline-diagnostic.nvim",
  event = "LspAttach",
  priority = 1000,
  config = function()
    require("tiny-inline-diagnostic").setup({
      preset = "modern",
      hi = {
        error = "DiagnosticError",
        warn = "DiagnosticWarn",
        info = "DiagnosticInfo",
        hint = "DiagnosticHint",
        arrow = "NonText",
        background = "CursorLine",
        mixing_color = "Normal",
      },
      options = {
        show_source = {
          enabled = false,
          if_many = false,
        },
        throttle = 20,
        softwrap = 30,
        multilines = {
          enabled = false,
        },
        show_all_diags_on_cursorline = false,
        enable_on_insert = false,
        enable_on_select = false,
        overflow = {
          mode = "wrap",
          padding = 0,
        },
        break_line = {
          enabled = false,
          after = 30,
        },
        virt_texts = {
          priority = 2048,
        },
        severity = {
          vim.diagnostic.severity.ERROR,
          vim.diagnostic.severity.WARN,
          vim.diagnostic.severity.INFO,
          vim.diagnostic.severity.HINT,
        },
      },
    })
  end,
}