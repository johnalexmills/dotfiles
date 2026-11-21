-- The mini.* repos moved from echasnovski/ to the nvim-mini/ organisation.
return {
  "nvim-mini/mini.pairs",
  event = "InsertEnter",
  -- Defaults: (), [], {}, "", '', `` in insert mode, not after a backslash,
  -- and ' not after a letter. The old explicit `mappings` table restated
  -- these in a pattern format upstream has since replaced.
  opts = {},
}
