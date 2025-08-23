return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" },
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "copilot-chat" },
        },
        ft = { "markdown", "copilot-chat" },
      },
    },
    opts = {
      debug = false,
      model = "gpt-4o",
      temperature = 0.1,
      headers = {
        user = "## User ",
        assistant = "## Copilot ",
        tool = "## Tool ",
      },
      separator = " ",
      show_folds = true,
      show_help = true,
      auto_follow_cursor = true,
      auto_insert_mode = false,
      clear_chat_on_new_prompt = false,
      history_path = vim.fn.stdpath("data") .. "/copilotchat_history",
    },
    config = function(_, opts)
      local chat = require("CopilotChat")
      chat.setup(opts)

      vim.api.nvim_create_user_command("CopilotChatVisual", function(args)
        chat.ask(args.args, { selection = require("CopilotChat.select").visual })
      end, { nargs = "*", range = true })

      vim.api.nvim_create_user_command("CopilotChatInline", function(args)
        chat.ask(args.args, {
          selection = require("CopilotChat.select").visual,
          window = { layout = "float", relative = "cursor", width = 1, height = 0.4, row = 1 }
        })
      end, { nargs = "*", range = true })
    end,
    event = "VeryLazy",
    keys = {
      {
        "<leader>cct",
        "<cmd>CopilotChatToggle<cr>",
        desc = "CopilotChat - Toggle",
      },
      {
        "<leader>ccx",
        "<cmd>CopilotChatReset<cr>",
        desc = "CopilotChat - Reset chat history and clear buffer",
      },
    },
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })
    end,
  },
  {
    "AndreM222/copilot-lualine",
  },
}
