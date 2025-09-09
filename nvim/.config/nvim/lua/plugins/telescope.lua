return {
  "nvim-telescope/telescope.nvim",
  cmd = { "Telescope" },
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    -- Quick access keys
    { "<leader>f", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
    { "<leader>F", "<cmd>Telescope live_grep<cr>", desc = "Find Text" },
    { "<leader>b", "<cmd>Telescope buffers<cr>", desc = "Buffers" },

    -- Telescope group
    { "<leader>t", group = "Telescope" },
    { "<leader>tv", group = "Vim" },

    -- File and text search
    { "<leader>tf", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
    { "<leader>tg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
    { "<leader>ts", "<cmd>Telescope grep_string<cr>", desc = "Grep String" },
    { "<leader>tr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
    { "<leader>tb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },

    -- Git integration (moved to <leader>g)
    { "<leader>gf", "<cmd>Telescope git_files<cr>", desc = "Git Files" },
    { "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Git Branches" },
    { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Git Commits" },
    { "<leader>gC", "<cmd>Telescope git_bcommits<cr>", desc = "Buffer Commits" },
    { "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "Git Status" },
    { "<leader>gS", "<cmd>Telescope git_stash<cr>", desc = "Git Stash" },

    -- Vim internals
    { "<leader>tvh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
    { "<leader>tvk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
    { "<leader>tvc", "<cmd>Telescope commands<cr>", desc = "Commands" },
    { "<leader>tvm", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
    { "<leader>tvr", "<cmd>Telescope registers<cr>", desc = "Registers" },
    { "<leader>tvs", "<cmd>Telescope colorscheme<cr>", desc = "Colorschemes" },
    { "<leader>tvo", "<cmd>Telescope vim_options<cr>", desc = "Vim Options" },
    { "<leader>tvj", "<cmd>Telescope jumplist<cr>", desc = "Jump List" },
    { "<leader>tvq", "<cmd>Telescope quickfix<cr>", desc = "Quickfix List" },
    { "<leader>tvl", "<cmd>Telescope loclist<cr>", desc = "Location List" },

    -- Search group (keeping backward compatibility)
    { "<leader>s", group = "Search" },
    { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
    { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
    { "<leader>sR", "<cmd>Telescope registers<cr>", desc = "Registers" },
    { "<leader>sb", "<cmd>Telescope git_branches<cr>", desc = "Checkout branch" },
    { "<leader>sc", "<cmd>Telescope colorscheme<cr>", desc = "Colorscheme" },
    { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Find Help" },
    { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
    { "<leader>sr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
  },
  -- Note: ripgrep must be installed on your system for live_grep to work
  config = function()
    local actions = require "telescope.actions"
    local telescope = require "telescope"
    telescope.setup {
      pickers = {
        find_files = {
          hidden = true,
          find_command = { "fd", "--type", "f", "--hidden", "--follow", "--exclude", ".git" },
        },
        live_grep = {
          only_sort_text = true,
          previewer = true,
          layout_config = {
            horizontal = {
              width = 0.9,
              height = 0.75,
              preview_width = 0.6,
            },
          },
        },
      },
      defaults = {
        prompt_prefix = "   ",
        selection_caret = "  ",
        entry_prefix = "  ",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--hidden",
          "--glob=!.git/",
        },
        file_ignore_patterns = {
          "^%.git/",
          "%.git$",
          "node_modules/",
          "%.DS_Store$",
          "%.cache/",
          "%.npm/",
          "%.venv/",
          "__pycache__/",
          "%.pyc$",
          "%.tmp$",
          "%.swp$",
        },

        mappings = {
          i = {
            ["<esc>"] = actions.close,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
          },
        },
      },
    }
  end,
}
