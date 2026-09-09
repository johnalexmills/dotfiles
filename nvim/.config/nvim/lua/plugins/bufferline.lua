return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = { "folke/snacks.nvim" },
  event = "VeryLazy",
  config = function()
    require("bufferline").setup {
      options = {
        close_command = function(n)
          require("snacks").bufdelete(n)
        end,
        right_mouse_command = function(n)
          require("snacks").bufdelete(n)
        end,
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(_count, _level, diagnostics_dict, _context)
          local s = ""
          for e, n in pairs(diagnostics_dict) do
            local sym = e == "error" and " " or (e == "warning" and " " or "")
            if s ~= "" then
              s = s .. " "
            end
            s = s .. n .. sym
          end
          if s ~= "" then
            s = " " .. s
          end
          return s
        end,
        separator_style = "slope",
      },
      -- bufferline derives its palette from Normal's bg, which is nil with
      -- transparent_background=true, so every group resolves to "NONE"
      -- (the slope glyphs rendered white). Pin the mocha palette explicitly.
      highlights = {
        fill = { bg = "#11111b" },
        background = { bg = "#181825", fg = "#a6adc8" },
        buffer = { bg = "#181825", fg = "#a6adc8" },
        buffer_visible = { bg = "#313244", fg = "#cdd6f4" },
        buffer_selected = { bg = "#1e1e2e", fg = "#cdd6f4" },
        separator = { fg = "#181825" },
        separator_visible = { fg = "#313244" },
        separator_selected = { fg = "#1e1e2e" },
        tab = { bg = "#181825", fg = "#a6adc8" },
        tab_selected = { bg = "#1e1e2e", fg = "#cdd6f4" },
        tab_separator = { fg = "#181825" },
        tab_separator_selected = { fg = "#1e1e2e" },
        close_button = { bg = "#181825", fg = "#9399b2" },
        close_button_visible = { bg = "#313244", fg = "#9399b2" },
        close_button_selected = { bg = "#1e1e2e", fg = "#9399b2" },
        group_separator = { fg = "#11111b" },
      },
    }
  end,
}
