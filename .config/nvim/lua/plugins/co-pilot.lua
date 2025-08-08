return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = { "InsertEnter", "LspAttach" },
    dependencies = {
      "zbirenbaum/copilot-cmp",
    },

    config = function()
      require("copilot").setup {
        panel = {
          enabled = true,
        },
        suggestion = {
          enabled = false,
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
        copilot_node_command = "node",
      }
    end,
  },

  {
    "zbirenbaum/copilot-cmp",
    after = { "copilot.lua" },
    event = { "InsertEnter", "LspAttach" },
    fix_pairs = true,
    config = function()
      require("copilot_cmp").setup()
    end,
  },

  {
    "AndreM222/copilot-lualine",
  },

  {
    "CopilotC-Nvim/CopilotChat.nvim",
    cmd = { "CopilotChat", "CopilotChatToggle" },
    dependencies = {
      { "nvim-lua/plenary.nvim", branch = "master" },
      { "zbirenbaum/copilot.lua" },
    },
    config = function()
      require("CopilotChat").setup {
        model = 'claude-sonnet-4',
        provider = 'copilot',
        commands = {
          open = {
            function()
              require("CopilotChat.ui").open()
            end,
          },
        },
      }
    end,
  },
}
