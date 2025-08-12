return {
    "rmagatti/auto-session",
    lazy = false,
    dependencies = {
        "nvim-telescope/telescope.nvim",
    },
    opts = {
        auto_restore_enabled = false,
        auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
        session_lens = {
            buftypes_to_ignore = {},
            load_on_setup = true,
            theme_conf = { border = true },
            previewer = false,
        },
    },
}
