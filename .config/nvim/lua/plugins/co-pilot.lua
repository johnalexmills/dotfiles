return {
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
