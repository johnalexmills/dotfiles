return {
  "saghen/blink.cmp",
  event = "InsertEnter",
  cond = function()
    return vim.bo.filetype ~= "oil"
  end,
  version = "*",
  dependencies = {
    "rafamadriz/friendly-snippets",
  },
  opts = {
    keymap = {
      preset = "default",
      ["<C-p>"] = { "select_prev", "fallback" },
      ["<C-n>"] = { "select_next", "fallback" },
      ["<Up>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },
      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },
      ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-e>"] = { "hide", "fallback" },
      ["<CR>"] = { "accept", "fallback" },
      ["<Tab>"] = { "snippet_forward", "select_next", "fallback" },
      ["<S-Tab>"] = { "snippet_backward", "select_prev", "fallback" },
    },
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono",
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
      providers = {
        buffer = {
          name = "Buffer",
          module = "blink.cmp.sources.buffer",
          score_offset = -3,
        },
        snippets = {
          name = "Snippets",
          module = "blink.cmp.sources.snippets",
          score_offset = -1,
          opts = {
            friendly_snippets = true,
            search_paths = { vim.fn.stdpath "config" .. "/snippets" },
            global_snippets = { "all" },
            extended_filetypes = {},
            ignored_filetypes = {},
          },
        },
        lsp = {
          name = "LSP",
          module = "blink.cmp.sources.lsp",
          fallbacks = { "buffer" },
        },
        path = {
          name = "Path",
          module = "blink.cmp.sources.path",
          score_offset = 3,
        },
      },
    },
    completion = {
      accept = {
        auto_brackets = {
          enabled = true,
        },
        create_undo_point = true,
      },
      menu = {
        border = "rounded",
        scrollbar = false,
        draw = {
          treesitter = { "lsp" },
          columns = { { "kind_icon" }, { "label", "label_description", gap = 1 } },
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 100, -- Reduced from 200ms for faster response
        window = {
          border = "rounded",
        },
      },
      ghost_text = {
        enabled = false,
      },
      list = {
        max_items = 50, -- Limit items for performance
      },
    },
    signature = {
      enabled = true,
      window = {
        border = "rounded",
      },
    },
  },
  opts_extend = { "sources.default" },
}
