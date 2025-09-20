return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = "Oil",
  keys = {
    { "-", "<CMD>Oil --float<CR>", desc = "Explorer (Float)" },
  },
  config = function()
    require("oil").setup {
      default_file_explorer = true,
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      view_options = {
        show_hidden = true,
        is_always_hidden = function(name, _)
          return name == ".." or name == ".git"
        end,
      },
      columns = {
        "icon",
      },
      float = {
        padding = 2,
        max_width = 0.9,
        max_height = 0.9,
        win_options = {
          winblend = 0,
        },
        override = function(conf)
          conf.title = vim.fn.fnamemodify(require("oil").get_current_dir(), ":~")
          return conf
        end,
      },
      win_options = {
        wrap = true,
        winblend = 0,
      },
      keymaps = {
        ["<C-c>"] = false,
        ["q"] = "actions.close",
      },
    }
  end,
}
