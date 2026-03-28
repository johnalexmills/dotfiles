local picker_exclude = {
  ".git",
  "node_modules",
  ".npm",
  "vendor",
  ".bundle",
  ".venv",
  "venv",
  "env",
  "__pycache__",
  ".egg-info",
  ".pytest_cache",
  ".mypy_cache",
  ".tox",
  ".terragrunt-cache",
  ".terraform",
  "target",
  "out",
  "bin",
  "obj",
  ".cache",
  ".idea",
  ".vscode",
  ".vs",
  "coverage",
  "htmlcov",
}

return {
  "folke/snacks.nvim",
  lazy = false,
  priority = 900,
  keys = {
    {
      "<C-\\>",
      function()
        Snacks.terminal(nil, { win = { position = "float" } })
      end,
      desc = "Toggle Terminal",
      mode = { "n", "t" },
    },
    {
      "<leader>gg",
      function()
        Snacks.terminal("lazygit", { cwd = Snacks.git.get_root() })
      end,
      desc = "LazyGit",
    },
    {
      "<leader>c",
      function()
        Snacks.bufdelete()
      end,
      desc = "Close Buffer",
    },
    {
      "<leader>fr",
      function()
        Snacks.rename.rename_file()
      end,
      desc = "Rename File",
    },
    {
      "<leader>z",
      function()
        Snacks.zen()
      end,
      desc = "Toggle Zen Mode",
    },

    -- Picker keymaps (replaces Telescope)
    {
      "<leader>sf",
      function()
        Snacks.picker.files()
      end,
      desc = "Find Files",
    },
    {
      "<leader>sg",
      function()
        Snacks.picker.grep()
      end,
      desc = "Live Grep",
    },
    {
      "<leader>ss",
      function()
        Snacks.picker.grep_word()
      end,
      desc = "Grep Word",
      mode = { "n", "x" },
    },
    {
      "<leader>sb",
      function()
        Snacks.picker.buffers()
      end,
      desc = "Buffers",
    },
    {
      "<leader>sh",
      function()
        Snacks.picker.help()
      end,
      desc = "Help Tags",
    },
    {
      "<leader>sK",
      function()
        Snacks.picker.keymaps()
      end,
      desc = "Keymaps",
    },
    {
      "<leader>sc",
      function()
        Snacks.picker.commands()
      end,
      desc = "Commands",
    },
    {
      "<leader>sm",
      function()
        Snacks.picker.man()
      end,
      desc = "Man Pages",
    },
    {
      "<leader>sr",
      function()
        Snacks.picker.registers()
      end,
      desc = "Registers",
    },
    {
      "<leader>sC",
      function()
        Snacks.picker.colorschemes()
      end,
      desc = "Colorschemes",
    },
    {
      "<leader>sT",
      function()
        Snacks.picker.todo_comments()
      end,
      desc = "Todo Comments",
    },
    {
      "<leader>so",
      function()
        Snacks.picker.autocmds()
      end,
      desc = "Autocmds",
    },

    -- Git pickers
    {
      "<leader>gf",
      function()
        Snacks.picker.git_files()
      end,
      desc = "Git Files",
    },
    {
      "<leader>gB",
      function()
        Snacks.picker.git_branches()
      end,
      desc = "Git Branches",
    },
    {
      "<leader>gc",
      function()
        Snacks.picker.git_log()
      end,
      desc = "Git Commits",
    },
    {
      "<leader>gC",
      function()
        Snacks.picker.git_log_file()
      end,
      desc = "Buffer Commits",
    },
    {
      "<leader>gs",
      function()
        Snacks.picker.git_status()
      end,
      desc = "Git Status",
    },

    -- Diff current buffer with a file
    {
      "<leader>sd",
      function()
        Snacks.picker.files {
          confirm = function(picker, item)
            picker:close()
            if item then
              vim.cmd("vertical diffsplit " .. vim.fn.fnameescape(item.file))
            end
          end,
        }
      end,
      desc = "Diff With File",
    },

    -- Undo (replaces undotree)
    {
      "<leader>u",
      function()
        Snacks.picker.undo()
      end,
      desc = "Undo History",
    },
  },
  opts = {
    input = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = false },
    terminal = { enabled = true },
    rename = { enabled = true },
    zen = { enabled = true },
    indent = {
      enabled = true,
      -- scope hl defined in colorscheme.lua using Catppuccin Mocha lavender
      scope = {
        hl = "SnacksIndentScope",
      },
    },
    picker = {
      enabled = true,
      sources = {
        files = {
          hidden = true,
          ignored = false,
          exclude = picker_exclude,
        },
        grep = {
          hidden = true,
          ignored = false,
          exclude = picker_exclude,
        },
      },
    },
    dashboard = {
      enabled = true,
      preset = {
        header = table.concat({
          [[                                                                       ]],
          [[                                                                       ]],
          [[                                                                       ]],
          [[                                                                       ]],
          [[                                                                     ]],
          [[       ████ ██████           █████      ██                     ]],
          [[      ███████████             █████                             ]],
          [[      █████████ ███████████████████ ███   ███████████   ]],
          [[     █████████  ███    █████████████ █████ ██████████████   ]],
          [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
          [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
          [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
          [[                                                                       ]],
          [[                                                                       ]],
          [[                                                                       ]],
        }, "\n"),
      },
      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup" },
      },
    },
  },
}
