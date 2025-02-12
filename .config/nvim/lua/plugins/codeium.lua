return {
  "Exafunction/codeium.nvim",
  cmd = "Codeium",
  event = { "BufEnter" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
  },

  config = function()
    require("codeium").setup {
      enable_chat = true,
      virtual_text = {
        enabled = true,
        key_bindings = {
          -- Accept the current completion.
          accept = "<M-l>",
          -- Accept the next word.
          accept_word = false,
          -- Accept the next line.
          accept_line = false,
          -- Clear the virtual text.
          clear = false,
          -- Cycle to the next completion.
          next = "<M-]>",
          -- Cycle to the previous completion.
          prev = "<M-[>",
        },
      },
    }
  end,
}
