return {
  "echasnovski/mini.comment",
  keys = {
    { "gcc", mode = "n", desc = "Comment toggle current line" },
    { "gc", mode = { "n", "o" }, desc = "Comment toggle linewise" },
    { "gc", mode = "x", desc = "Comment toggle linewise (visual)" },
  },
  opts = {
    options = {
      custom_commentstring = nil,
      ignore_blank_line = false,
      start_of_line = false,
      pad_comment_parts = true,
    },
    mappings = {
      comment = 'gc',
      comment_line = 'gcc',
      comment_visual = 'gc',
      textobject = 'gc',
    },
  },
}
