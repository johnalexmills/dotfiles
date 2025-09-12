return {
  "nvim-telescope/telescope.nvim",
  cmd = { "Telescope" },
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    -- Telescope group (organized)
    { "<leader>t", group = "Telescope" },
    { "<leader>tf", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
    { "<leader>tg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
    { "<leader>ts", "<cmd>Telescope grep_string<cr>", desc = "Grep String" },
    { "<leader>tb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
    { "<leader>th", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
    { "<leader>tK", "<cmd>Telescope keymaps<cr>", desc = "Telescope Keymaps" },
    { "<leader>tc", "<cmd>Telescope commands<cr>", desc = "Commands" },
    { "<leader>tm", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
    { "<leader>tr", "<cmd>Telescope registers<cr>", desc = "Registers" },
    { "<leader>tC", "<cmd>Telescope colorscheme<cr>", desc = "Colorschemes" },
    { "<leader>to", "<cmd>Telescope vim_options<cr>", desc = "Vim Options" },

    -- Git integration
    { "<leader>gf", "<cmd>Telescope git_files<cr>", desc = "Git Files" },
    { "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Git Branches" },
    { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Git Commits" },
    { "<leader>gC", "<cmd>Telescope git_bcommits<cr>", desc = "Buffer Commits" },
    { "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "Git Status" },
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
          "%.terragrunt%-cache/",
          "%.terraform/",
          "%.terraform%.lock%.hcl$",
          "terragrunt%.hcl$",
        },

        borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
        
        mappings = {
          i = {
            ["<esc>"] = actions.close,
            ["<C-n>"] = actions.move_selection_next,
            ["<C-p>"] = actions.move_selection_previous,
          },
        },
      },
    }
  end,
}
