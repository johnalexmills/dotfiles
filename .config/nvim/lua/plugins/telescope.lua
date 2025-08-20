return {
    "nvim-telescope/telescope.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local actions = require "telescope.actions"
        local telescope = require "telescope"
        telescope.setup {
            pickers = {
                find_files = {
                    hidden = true,
                    file_ignore_patterns = {
                        "%.git/", -- Ignore .git directory
                        "%.git$", -- Ignore .git files
                        "node_modules/", -- You might want to ignore these too
                        "%.DS_Store$", -- macOS system files
                        "%.cache/", -- Cache directories
                        "%.npm/", -- npm cache
                        "%.venv/", -- Python virtual environments
                        "__pycache__/", -- Python cache
                        "%.pyc$", -- Python compiled files
                        "%.tmp$", -- Temporary files
                        "%.swp$", -- Vim swap files
                    },
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
                    "%.git/",
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
