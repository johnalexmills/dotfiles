return {
  "RRethy/vim-illuminate",
  event = "VeryLazy",
  config = function()
    require("illuminate").configure {
      filetypes_denylist = {
        "dirvish",
        "fugitive",
        "alpha",
        "NvimTree",
        "lazy",
        "neogitstatus",
        "netrw",
        "Trouble",
        "lir",
        "Outline",
        "spectre_panel",
        "toggleterm",
        "DressingSelect",
        "TelescopePrompt",
      },
    }
  end,
}
