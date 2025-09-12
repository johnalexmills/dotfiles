return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("bufferline").setup {
      options = {
        close_command = "Bdelete! %d",
        right_mouse_command = "Bdelete! %d",
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          local s = " "
          for e, n in pairs(diagnostics_dict) do
            local sym = e == "error" and " " or (e == "warning" and " " or "")
            s = s .. n .. sym
          end
          return s
        end,
        separator_style = "slant",
        offsets = {
          {
            filetype = "oil",
            text = "Oil",
          },
        },
      },
    }
  end,
}
