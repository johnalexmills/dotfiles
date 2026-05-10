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
        separator_style = "slant",
      },
    }
  end,
}
