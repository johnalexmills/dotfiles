return {
  "echasnovski/mini.indentscope",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    symbol = "│",
    options = { try_as_border = true },
    draw = {
      delay = 100,
      animation = function()
        return 20
      end,
    },
    mappings = {
      object_scope = "ii",
      object_scope_with_border = "ai",
      goto_top = "[i",
      goto_bottom = "]i",
    },
  },
  init = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "alpha",

        "dashboard",
        "help",
        "lazy",
        "lazyterm",
        "mason",
        "notify",
        "oil",
        "toggleterm",
        "Trouble",
      },
      callback = function()
        vim.b.miniindentscope_disable = true
      end,
    })
  end,
}
