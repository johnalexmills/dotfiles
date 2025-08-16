return {
  "echasnovski/mini.cursorword",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require('mini.cursorword').setup({
      delay = 100, -- Delay before highlighting (ms)
    })
  end,
}