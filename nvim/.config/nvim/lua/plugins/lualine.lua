-- Set lualine as statusline
return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  config = function()
    local mode = {
      "mode",
      fmt = function(str)
        -- return ' ' .. str:sub(1, 1) -- displays only the first character of the mode
        return " " .. str
      end,
    }

    local filename = {
      "filename",
      path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
    }

    local hide_in_width = function()
      return vim.fn.winwidth(0) > 100
    end

    local diagnostics = {
      "diagnostics",
      sources = { "nvim_lsp" },
      sections = { "error", "warn" },
      symbols = { error = " ", warn = " ", info = " ", hint = " " },
      cond = hide_in_width,
    }
    local lsp_info = {
      function()
        local clients = vim.lsp.get_clients { bufnr = 0 }
        local names = {}
        for _, client in ipairs(clients) do
          table.insert(names, client.name)
        end
        return " LSP: " .. table.concat(names, ", ")
      end,
      cond = function()
        return #vim.lsp.get_clients { bufnr = 0 } > 0
      end,
    }

    local diff = {
      "diff",
      symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
      cond = hide_in_width,
    }

    require("lualine").setup {
      options = {
        icons_enabled = true,
        theme = "catppuccin-nvim", -- match the catppuccin colorscheme (v2.0+ name)
        -- Some useful glyphs:
        -- https://www.nerdfonts.com/cheat-sheet
        --        
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
        disabled_filetypes = { "snacks_dashboard" },
      },
      sections = {
        lualine_a = { mode },
        lualine_b = { "branch" },
        lualine_c = { filename },
        lualine_x = {
          lsp_info,
          diagnostics,
          diff,
        },
        lualine_y = { "location" },
        lualine_z = {
          "progress",
          { "encoding", cond = hide_in_width },
          { "filetype", cond = hide_in_width },
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { { "location", padding = 0 } },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = {},
    }
  end,
}
