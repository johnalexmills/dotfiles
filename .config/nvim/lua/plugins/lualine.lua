return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-lua/lsp-status.nvim" },
  event = { "InsertEnter", "BufReadPre", "BufAdd", "BufNew", "BufReadPost" },
  config = function()
    -- local config = require "configs.lualine"
    -- require("lualine").setup(config)
    local status_ok, lualine = pcall(require, "lualine")
    if not status_ok then
      return
    end

    local hide_in_width = function()
      return vim.fn.winwidth(0) > 80
    end

    local diagnostics = {
      "diagnostics",
      sources = { "nvim_diagnostic" },
      sections = { "error", "warn" },
      symbols = { error = " ", warn = " " },
      colored = false,
      always_visible = true,
    }

    local lsp_info = {
      function()
        local msg = "No Active Lsp"
        local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
        local clients = vim.lsp.get_active_clients()
        if next(clients) == nil then
          return msg
        end
        for _, client in ipairs(clients) do
          local filetypes = client.config.filetypes
          if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            return client.name
          end
        end
        return msg
      end,
      icon = { " LSP:" },
      color = { { fg = "#ffffff", gui = "bold" } },
    }

    local diff = {
      "diff",
      colored = false,
      symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
      cond = hide_in_width,
    }

    local filetype = {
      "filetype",
      icons_enabled = true,
    }

    local filename = {
      "filename",
      icons_enabled = false,
    }

    local location = {
      "location",
      padding = 0,
    }

    local spaces = function()
      return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
    end

    lualine.setup {
      extensions = { "toggleterm" },
      options = {
        globalstatus = true,
        icons_enabled = true,
        theme = "auto",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = { "alpha", "dashboard" },
        always_divide_middle = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "buffers" },
        lualine_c = { { "copilot", show_colors = true }, lsp_info, diagnostics },
        lualine_x = { "searchcount", "selectioncount", diff, spaces, "encoding", "filesize", filename, filetype },
        lualine_y = { location },
        lualine_z = { "progress" },
      },
    }
  end,
}
