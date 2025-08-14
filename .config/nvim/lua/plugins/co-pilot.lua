return {
  -- Main Copilot plugin
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    dependencies = { "zbirenbaum/copilot-cmp" },
    config = function()
      require("copilot").setup {
        panel = { enabled = true },
        suggestion = {
          enabled = true,
          auto_trigger = true,
          hide_during_completion = true,
          debounce = 75,
          keymap = {
            accept = "<M-l>",
            accept_word = false,
            accept_line = false,
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
          },
        },
        filetypes = {
          markdown = true,
          help = false,
          gitcommit = false,
          gitrebase = false,
          hgcommit = false,
          svn = false,
          cvs = false,
          ["."] = false,
        },
        copilot_node_command = vim.env.COPILOT_NODE_CMD or "node",
      }
    end,
  },

  -- Copilot completion source for nvim-cmp
  {
    "zbirenbaum/copilot-cmp",
    event = "InsertEnter",
    config = function()
      require("copilot_cmp").setup()
    end,
  },

  -- Copilot status for lualine
  { "AndreM222/copilot-lualine" },

  -- CopilotChat integration
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    cmd = { "CopilotChat", "CopilotChatToggle" },
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "zbirenbaum/copilot.lua" },
    },
    config = function()
      require("CopilotChat").setup {
        model = 'claude-sonnet-4',
        provider = 'copilot',
        commands = {
          open = function()
            require("CopilotChat.ui").open()
          end,
        },
      }
    end,
  },
}
