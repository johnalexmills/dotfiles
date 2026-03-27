return {
  "nvim-telescope/telescope.nvim",
  cmd = { "Telescope" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
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
    { "<leader>td", desc = "Diff with file" },

    -- Git integration
    { "<leader>gf", "<cmd>Telescope git_files<cr>", desc = "Git Files" },
    { "<leader>gB", "<cmd>Telescope git_branches<cr>", desc = "Git Branches" },
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
          "--glob=!.mypy_cache/",
        },
        file_ignore_patterns = {
          -- Version control
          "^%.git/",
          "%.git$",
          "%.gitignore$",

          -- Dependencies
          "node_modules/",
          "%.npm/",
          "vendor/",
          "%.bundle/",

          -- Python
          "%.venv/",
          "venv/",
          "env/",
          "__pycache__/",
          "%.pyc$",
          "%.pyo$",
          "%.egg%-info/",
          "dist/",
          "build/",
          "%.pytest_cache/",
          "%.mypy_cache/",
          "%.tox/",

          -- Terraform
          "%.terragrunt%-cache/",
          "%.terraform/",
          "%.terraform%.lock%.hcl$",
          "terragrunt%.hcl$",

          -- Build artifacts
          "target/",
          "out/",
          "bin/",
          "obj/",

          -- Lock files
          "package%-lock%.json$",
          "yarn%.lock$",
          "pnpm%-lock%.yaml$",
          "Cargo%.lock$",
          "Gemfile%.lock$",
          "composer%.lock$",
          "poetry%.lock$",

          -- Cache and temp files
          "%.cache/",
          "%.tmp$",
          "%.temp$",
          "%.swp$",
          "%.swo$",
          "%.bak$",
          "~$",

          -- OS files
          "%.DS_Store$",
          "Thumbs%.db$",
          "desktop%.ini$",

          -- IDE
          "%.idea/",
          "%.vscode/",
          "%.vs/",

          -- Logs
          "%.log$",
          "logs/",

          -- Coverage
          "coverage/",
          "%.coverage$",
          "htmlcov/",

          -- Misc
          "%.min%.js$",
          "%.min%.css$",
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

    -- Load fzf extension for faster fuzzy finding
    telescope.load_extension "fzf"

    -- Diff current buffer against a file picked with Telescope
    vim.keymap.set("n", "<leader>td", function()
      local current_file = vim.fn.expand "%:p"
      require("telescope.builtin").find_files {
        attach_mappings = function(_, map)
          local function open_diff(prompt_bufnr)
            local entry = require("telescope.actions.state").get_selected_entry()
            require("telescope.actions").close(prompt_bufnr)
            if entry and entry.path ~= current_file then
              vim.cmd("vertical diffsplit " .. vim.fn.fnameescape(entry.path))
            end
          end
          map("i", "<CR>", open_diff)
          map("n", "<CR>", open_diff)
          return true
        end,
      }
    end, { desc = "Diff with file" })
  end,
}
