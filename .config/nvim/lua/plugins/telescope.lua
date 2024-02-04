return {
  "nvim-telescope/telescope.nvim",
  event = "Bufenter",
  cmd = { "Telescope" },
  dependencies = {
    {
      "nvim-lua/plenary.nvim",
      "BurntSushi/ripgrep",
      "nvim-telescope/telescope-project.nvim",
    },
  },
  config = function()
    local actions = require "telescope.actions"
    local telescope = require "telescope"
    telescope.setup {
      defaults = {
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
        git_files = {
          hidden = true,
          previewer = false,
          layout_config = {
            horizontal = {
              width = 0.5,
              height = 0.4,
              preview_width = 0.6,
            },
          },
        },
        live_grep = {
          --@usage don't include the filename in the search results
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
        mappings = {
          i = {
            ["<esc>"] = actions.close,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
          },
        },
      },
      extensions = {
        fzf = {
          fuzzy = true, -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          case_mode = "smart_case", -- or "ignore_case" or "respect_case"
        },
        project = {
          base_dirs = {
            "~/git-projects/",
          },
          hidden_files = true, -- default: false
          theme = "dropdown",
          order_by = "asc",
          search_by = "title",
          sync_with_nvim_tree = true, -- default false
        },
      },
    }
    local M = {}

    M.project_files = function()
      local opts = {}
      local ok = pcall(require("telescope.builtin").git_files, opts)
      if not ok then
        require("telescope.builtin").find_files(opts)
      end
    end

    return M
  end,
}
