return {
  {
    "olimorris/codecompanion.nvim",
    cmd = { "CodeCompanion", "CodeCompanionActions", "CodeCompanionToggle", "CodeCompanionAdd" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "hrsh7th/nvim-cmp", -- Optional: For using slash commands and variables in the chat buffer
      "nvim-telescope/telescope.nvim", -- Optional: For using slash commands
      { "stevearc/dressing.nvim", opts = {} }, -- Optional: Improves `vim.ui.select`
    },
    config = function()
      require("codecompanion").setup({
        strategies = {
          chat = {
            adapter = "copilot",
          },
          inline = {
            adapter = "copilot",
          },
          agent = {
            adapter = "copilot",
          },
        },
        adapters = {
          copilot = function()
            return require("codecompanion.adapters").extend("copilot", {
              schema = {
                model = {
                  default = "claude-sonnet-4",
                },
              },
            })
          end,
        },
        display = {
          action_palette = {
            provider = "telescope",
          },
          chat = {
            window = {
              layout = "vertical", -- float|vertical|horizontal|buffer
              border = "rounded",
              height = 0.8,
              width = 0.45,
              relative = "editor",
              opts = {
                breakindent = true,
                cursorcolumn = false,
                cursorline = false,
                foldcolumn = "0",
                linebreak = true,
                list = false,
                signcolumn = "no",
                spell = false,
                wrap = true,
              },
            },
            render_headers = true,
            show_settings = true,
          },
          diff = {
            provider = "mini_diff",
          },
        },
        opts = {
          log_level = "ERROR", -- TRACE|DEBUG|ERROR|INFO
          send_code = true, -- Send code context to the LLM? Disable to prevent leaking code outside of Neovim
          use_default_actions = true, -- Use the default actions in the action palette?
          use_default_prompts = true, -- Use the default prompts from the plugin?
        },
        commands = {
          slash_commands = true,
          auto_commands = true,
        },
        keymaps = {
          ["<C-s>"] = "keymaps.save",
          ["<C-c>"] = "keymaps.close",
          ["<C-l>"] = "keymaps.clear",
          ["<C-r>"] = "keymaps.regenerate",
        },
        markdown = {
          separator = "---",
          fence = "```",
        },
      })
    end,
  },
}