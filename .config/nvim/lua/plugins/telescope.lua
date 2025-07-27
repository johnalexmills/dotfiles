return {
    "nvim-telescope/telescope.nvim",
    cmd = { "Telescope" },
    keys = {
        { "<leader>f", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
        { "<leader>F", "<cmd>Telescope live_grep<cr>", desc = "Find Text" },
        { "<leader>b", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
        { "<leader>sr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
    },
    dependencies = {
        {
            "nvim-lua/plenary.nvim",
            "BurntSushi/ripgrep",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
            },
            "nvim-telescope/telescope-file-browser.nvim",
        },
    },
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
                file_browser = {
                    theme = "ivy",
                    hijack_netrw = true,
                },
            },
        }
        telescope.load_extension("fzf")
        telescope.load_extension("file_browser")
    end,
}
